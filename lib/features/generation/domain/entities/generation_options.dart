import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation_options.freezed.dart';
part 'generation_options.g.dart';

@freezed
abstract class GenerationOptions with _$GenerationOptions {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GenerationOptions({
    required String? goal,
    required int? durationMinutes,
    required String? voiceStyle,
    required String? backgroundSound,
  }) = _GenerationOptions;

  factory GenerationOptions.fromJson(Map<String, dynamic> json) =>
      _$GenerationOptionsFromJson(json);
}
