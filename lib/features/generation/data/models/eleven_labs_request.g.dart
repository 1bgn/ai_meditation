// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eleven_labs_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ElevenLabsRequest _$ElevenLabsRequestFromJson(Map<String, dynamic> json) =>
    _ElevenLabsRequest(
      text: json['text'] as String,
      modelId: json['model_id'] as String,
      voiceSettings: ElevenLabsVoiceSettings.fromJson(
        json['voice_settings'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ElevenLabsRequestToJson(_ElevenLabsRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'model_id': instance.modelId,
      'voice_settings': instance.voiceSettings,
    };

_ElevenLabsVoiceSettings _$ElevenLabsVoiceSettingsFromJson(
  Map<String, dynamic> json,
) => _ElevenLabsVoiceSettings(
  stability: (json['stability'] as num).toDouble(),
  similarityBoost: (json['similarity_boost'] as num).toDouble(),
);

Map<String, dynamic> _$ElevenLabsVoiceSettingsToJson(
  _ElevenLabsVoiceSettings instance,
) => <String, dynamic>{
  'stability': instance.stability,
  'similarity_boost': instance.similarityBoost,
};
