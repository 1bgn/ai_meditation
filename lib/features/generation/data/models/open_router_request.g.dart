// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenRouterRequest _$OpenRouterRequestFromJson(Map<String, dynamic> json) =>
    _OpenRouterRequest(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => OpenRouterMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenRouterRequestToJson(_OpenRouterRequest instance) =>
    <String, dynamic>{'model': instance.model, 'messages': instance.messages};

_OpenRouterMessage _$OpenRouterMessageFromJson(Map<String, dynamic> json) =>
    _OpenRouterMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$OpenRouterMessageToJson(_OpenRouterMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};
