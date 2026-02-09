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
      goal: 'Relax',
      durationMinutes: 10,
      voiceStyle: 'Soft',
      backgroundSound: 'Ocean',
    ),
  );
  final isGenerating = signal(false);
  final error = signal<String?>(null);

  void load() {
    options.value = _getOptions() ?? options.value;
  }

  Future<void> updateGoal(String goal) =>
      _update(options.value.copyWith(goal: goal));

  Future<void> updateDuration(int minutes) =>
      _update(options.value.copyWith(durationMinutes: minutes));

  Future<void> updateVoiceStyle(String style) =>
      _update(options.value.copyWith(voiceStyle: style));

  Future<void> updateBackgroundSound(String sound) =>
      _update(options.value.copyWith(backgroundSound: sound));

  Future<void> generate() async {
    isGenerating.value = true;
    error.value = null;
    try {
      await _saveOptions(options.value);
      await _generateMeditation(options.value);
      final historyItem = MeditationHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '${options.value.goal} Meditation',
        durationMinutes: options.value.durationMinutes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _addHistoryItem(historyItem);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isGenerating.value = false;
    }
  }

  Future<void> _update(GenerationOptions next) async {
    options.value = next;
    await _saveOptions(next);
  }
}
