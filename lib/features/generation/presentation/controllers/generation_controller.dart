import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/domain/usecases/add_history_item.dart';
import '../../domain/entities/generation_options.dart';
import '../../domain/usecases/generate_meditation.dart';
import '../../domain/usecases/get_generation_options.dart';
import '../../domain/usecases/save_generation_options.dart';

@lazySingleton
class GenerationController {
  GenerationController(
    this._getOptions,
    this._saveOptions,
    this._generateMeditation,
    this._addHistoryItem,
  );

  final GetGenerationOptions _getOptions;
  final SaveGenerationOptions _saveOptions;
  final GenerateMeditation _generateMeditation;
  final AddHistoryItem _addHistoryItem;

  final options = signal(
    const GenerationOptions(
      goal: null,
      durationMinutes: null,
      voiceStyle: null,
      backgroundSound: null,
    ),
  );

  final isGenerating = signal(false);
  final error = signal<String?>(null);
  final lastScript = signal<String?>(null);

  GenerationOptions _mergeOptions(
    GenerationOptions base,
    GenerationOptions patch,
  ) {
    return base.copyWith(
      goal: patch.goal ?? base.goal,
      durationMinutes: patch.durationMinutes ?? base.durationMinutes,
      voiceStyle: patch.voiceStyle ?? base.voiceStyle,
      backgroundSound: patch.backgroundSound ?? base.backgroundSound,
    );
  }

  /// Загружает сохранённые опции.
  /// Если передали [presets] — применяет их поверх сохранённых (только non-null поля).
  /// Presets НЕ сохраняются.
  Future<void> load({GenerationOptions? presets}) async {
    error.value = null;

    try {
      // Универсально: поддержит и GenerationOptions, и GenerationOptions?
      final GenerationOptions? stored =
          await _getOptions.call() as GenerationOptions?;

      final base = options.value;
      options.value = presets == null ? base : _mergeOptions(base, presets);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> updateGoal(String goal) =>
      _update(options.value.copyWith(goal: goal));

  Future<void> updateDuration(int minutes) =>
      _update(options.value.copyWith(durationMinutes: minutes));

  Future<void> updateVoiceStyle(String style) =>
      _update(options.value.copyWith(voiceStyle: style));

  Future<void> updateBackgroundSound(String sound) =>
      _update(options.value.copyWith(backgroundSound: sound));

  Future<String?> generate() async {
    final current = options.value;

    if (current.goal == null ||
        current.durationMinutes == null ||
        current.voiceStyle == null ||
        current.backgroundSound == null) {
      error.value =
          'Please select goal, duration, voice style and background sound.';
      return null;
    }

    isGenerating.value = true;
    error.value = null;

    try {
      // ВАЖНО: тут НЕ сохраняем options, чтобы одноразовые presets не затирали storage.
      final script = await _generateMeditation.call(current);
      lastScript.value = script;

      final historyItem = MeditationHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '${current.goal} Meditation',
        durationMinutes: current.durationMinutes!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _addHistoryItem.call(historyItem);

      return script;
    } catch (e) {
      error.value = e.toString();
      return null;
    } finally {
      isGenerating.value = false;
    }
  }

  Future<void> _update(GenerationOptions next) async {
    options.value = next;
    try {
      await _saveOptions.call(next); // сохраняем только явные изменения юзера
    } catch (e) {
      error.value = e.toString();
    }
  }
}
