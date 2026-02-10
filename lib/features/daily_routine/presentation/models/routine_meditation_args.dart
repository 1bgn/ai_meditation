class RoutineMeditationArgs {
  const RoutineMeditationArgs({
    required this.title,
    required this.goal,
    required this.durationMinutes,
    required this.voiceStyle,
    required this.backgroundSound,
  });

  final String title;
  final String goal;
  final int durationMinutes;
  final String voiceStyle;
  final String backgroundSound;
}
