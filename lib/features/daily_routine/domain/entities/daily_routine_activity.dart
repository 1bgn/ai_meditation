abstract class DailyRoutineActivity {
  const DailyRoutineActivity({
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.imageAsset,
    required this.badgeText,
    required this.goal,
    required this.voiceStyle,
    required this.backgroundSound,
  });

  final String title;
  final String description;
  final int durationMinutes;
  final String imageAsset;
  final String badgeText;
  final String goal;
  final String voiceStyle;
  final String backgroundSound;
}

class DailyRoutineMeditation extends DailyRoutineActivity {
  const DailyRoutineMeditation({
    required String title,
    required String description,
    required int durationMinutes,
    required String imageAsset,
    required String badgeText,
    required String goal,
    required String voiceStyle,
    required String backgroundSound,
  }) : super(
          title: title,
          description: description,
          durationMinutes: durationMinutes,
          imageAsset: imageAsset,
          badgeText: badgeText,
          goal: goal,
          voiceStyle: voiceStyle,
          backgroundSound: backgroundSound,
        );
}

class DailyRoutineBreathing extends DailyRoutineActivity {
  const DailyRoutineBreathing({
    required String title,
    required String description,
    required int durationMinutes,
    required String imageAsset,
    required String badgeText,
    required String goal,
    required String voiceStyle,
    required String backgroundSound,
    required this.inhaleSeconds,
    required this.exhaleSeconds,
  }) : super(
          title: title,
          description: description,
          durationMinutes: durationMinutes,
          imageAsset: imageAsset,
          badgeText: badgeText,
          goal: goal,
          voiceStyle: voiceStyle,
          backgroundSound: backgroundSound,
        );

  final int inhaleSeconds;
  final int exhaleSeconds;
}
