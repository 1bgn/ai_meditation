// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerationOptions _$GenerationOptionsFromJson(Map<String, dynamic> json) =>
    _GenerationOptions(
      goal: json['goal'] as String?,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      voiceStyle: json['voice_style'] as String?,
      backgroundSound: json['background_sound'] as String?,
    );

Map<String, dynamic> _$GenerationOptionsToJson(_GenerationOptions instance) =>
    <String, dynamic>{
      'goal': instance.goal,
      'duration_minutes': instance.durationMinutes,
      'voice_style': instance.voiceStyle,
      'background_sound': instance.backgroundSound,
    };
