import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_router_request.freezed.dart';
part 'open_router_request.g.dart';

@freezed
abstract class OpenRouterRequest with _$OpenRouterRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OpenRouterRequest({
    required String model,
    required List<OpenRouterMessage> messages,
  }) = _OpenRouterRequest;

  factory OpenRouterRequest.fromJson(Map<String, dynamic> json) =>
      _$OpenRouterRequestFromJson(json);
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
