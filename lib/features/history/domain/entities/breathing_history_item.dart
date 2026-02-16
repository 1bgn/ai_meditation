class BreathingHistoryItem {
  final String id;
  final String title;
  final int durationMinutes;
  final int inhaleSeconds;
  final int exhaleSeconds;
  final String? moodLabel;
  final DateTime createdAt;

  BreathingHistoryItem({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.inhaleSeconds,
    required this.exhaleSeconds,
    required this.createdAt,
    this.moodLabel,
  });

  factory BreathingHistoryItem.fromJson(Map<String, dynamic> json) =>
      BreathingHistoryItem(
        id: json['id'] as String,
        title: json['title'] as String,
        durationMinutes: json['durationMinutes'] as int,
        inhaleSeconds: json['inhaleSeconds'] as int,
        exhaleSeconds: json['exhaleSeconds'] as int,
        moodLabel: json['moodLabel'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'durationMinutes': durationMinutes,
    'inhaleSeconds': inhaleSeconds,
    'exhaleSeconds': exhaleSeconds,
    'moodLabel': moodLabel,
    'createdAt': createdAt.toIso8601String(),
  };
}
