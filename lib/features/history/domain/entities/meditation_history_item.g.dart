// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeditationHistoryItem _$MeditationHistoryItemFromJson(
  Map<String, dynamic> json,
) => _MeditationHistoryItem(
  id: json['id'] as String,
  title: json['title'] as String,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  isDeleted: json['is_deleted'] as bool? ?? false,
);

Map<String, dynamic> _$MeditationHistoryItemToJson(
  _MeditationHistoryItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'duration_minutes': instance.durationMinutes,
  'created_at': instance.createdAt.toIso8601String(),
  'is_deleted': instance.isDeleted,
};
