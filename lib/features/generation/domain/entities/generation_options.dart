import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation_options.freezed.dart';
part 'generation_options.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class GenerationOptions with _$GenerationOptions {
  const factory GenerationOptions({
    required String goal,
    required int durationMinutes,
    required String voiceStyle,
    required String backgroundSound,
  }) = _GenerationOptions;

  factory GenerationOptions.fromJson(Map<String, dynamic> json) =>
      _$GenerationOptionsFromJson(json);
}
