import 'package:freezed_annotation/freezed_annotation.dart';

part 'meditation_recommendation.freezed.dart';

@freezed
class MeditationRecommendation with _$MeditationRecommendation {
  const factory MeditationRecommendation({
    required String title,
    required String subtitle,
    required int durationMinutes,
  }) = _MeditationRecommendation;
}
