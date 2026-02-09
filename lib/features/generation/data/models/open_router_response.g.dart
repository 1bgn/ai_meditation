// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenRouterResponse _$OpenRouterResponseFromJson(Map<String, dynamic> json) =>
    _OpenRouterResponse(
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => OpenRouterChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OpenRouterResponseToJson(_OpenRouterResponse instance) =>
    <String, dynamic>{'choices': instance.choices};

_OpenRouterChoice _$OpenRouterChoiceFromJson(Map<String, dynamic> json) =>
    _OpenRouterChoice(
      message: OpenRouterMessage.fromJson(
        json['message'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$OpenRouterChoiceToJson(_OpenRouterChoice instance) =>
    <String, dynamic>{'message': instance.message};

_OpenRouterMessage _$OpenRouterMessageFromJson(Map<String, dynamic> json) =>
    _OpenRouterMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$OpenRouterMessageToJson(_OpenRouterMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};
