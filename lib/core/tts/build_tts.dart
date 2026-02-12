import 'package:just_audio/just_audio.dart';

class BuiltTts {
  BuiltTts({
    required this.source,
    required this.total,
    required this.chunkDurations,
  });

  final AudioSource source;
  final Duration total;
  final List<Duration> chunkDurations;
}
