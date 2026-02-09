import 'package:freezed_annotation/freezed_annotation.dart';

part 'meditation_history_item.freezed.dart';
part 'meditation_history_item.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MeditationHistoryItem with _$MeditationHistoryItem {
  const factory MeditationHistoryItem({
    required String id,
    required String title,
    required int durationMinutes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(includeFromJson: true, includeToJson: false)
    DateTime? updatedAt,
    @Default(false) bool isDeleted,
  }) = _MeditationHistoryItem;

  factory MeditationHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$MeditationHistoryItemFromJson(json);
}
