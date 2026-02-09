import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_router_response.freezed.dart';
part 'open_router_response.g.dart';

@freezed
abstract class OpenRouterResponse with _$OpenRouterResponse {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OpenRouterResponse({
    @Default([]) List<OpenRouterChoice> choices,
  }) = _OpenRouterResponse;

  factory OpenRouterResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenRouterResponseFromJson(json);
}

@freezed
abstract class OpenRouterChoice with _$OpenRouterChoice {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OpenRouterChoice({
    required OpenRouterMessage message,
  }) = _OpenRouterChoice;

  factory OpenRouterChoice.fromJson(Map<String, dynamic> json) =>
      _$OpenRouterChoiceFromJson(json);
}

@freezed
abstract class OpenRouterMessage with _$OpenRouterMessage {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OpenRouterMessage({
    required String role,
    required String content,
  }) = _OpenRouterMessage;

  factory OpenRouterMessage.fromJson(Map<String, dynamic> json) =>
      _$OpenRouterMessageFromJson(json);
}
