import 'package:freezed_annotation/freezed_annotation.dart';

part 'eleven_labs_request.freezed.dart';
part 'eleven_labs_request.g.dart';

@freezed
abstract class ElevenLabsRequest with _$ElevenLabsRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ElevenLabsRequest({
    required String text,
    required String modelId,
    required ElevenLabsVoiceSettings voiceSettings,
  }) = _ElevenLabsRequest;

  factory ElevenLabsRequest.fromJson(Map<String, dynamic> json) =>
      _$ElevenLabsRequestFromJson(json);
}

@freezed
abstract class ElevenLabsVoiceSettings with _$ElevenLabsVoiceSettings {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ElevenLabsVoiceSettings({
    required double stability,
    required double similarityBoost,
  }) = _ElevenLabsVoiceSettings;

  factory ElevenLabsVoiceSettings.fromJson(Map<String, dynamic> json) =>
      _$ElevenLabsVoiceSettingsFromJson(json);
}
