import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../../core/tts/tts_service.dart';

@injectable
class MeditationPlayerController {
  MeditationPlayerController(this._ttsService);

  final TtsService _ttsService;

  final isPlaying = signal(true);

  Future<void> stop() async {
    await _ttsService.stop();
    isPlaying.value = false;
  }
}
