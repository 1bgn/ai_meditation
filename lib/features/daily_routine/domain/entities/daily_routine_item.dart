import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_routine_item.freezed.dart';

@freezed
class DailyRoutineItem with _$DailyRoutineItem {
  const factory DailyRoutineItem({
    required String title,
    required String description,
    required int durationMinutes,
  }) = _DailyRoutineItem;
}
