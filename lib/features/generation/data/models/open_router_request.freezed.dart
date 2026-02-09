// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_router_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenRouterRequest {

 String get model; List<OpenRouterMessage> get messages;
/// Create a copy of OpenRouterRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenRouterRequestCopyWith<OpenRouterRequest> get copyWith => _$OpenRouterRequestCopyWithImpl<OpenRouterRequest>(this as OpenRouterRequest, _$identity);

  /// Serializes this OpenRouterRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenRouterRequest&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'OpenRouterRequest(model: $model, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $OpenRouterRequestCopyWith<$Res>  {
  factory $OpenRouterRequestCopyWith(OpenRouterRequest value, $Res Function(OpenRouterRequest) _then) = _$OpenRouterRequestCopyWithImpl;
@useResult
$Res call({
 String model, List<OpenRouterMessage> messages
});




}
/// @nodoc
class _$OpenRouterRequestCopyWithImpl<$Res>
    implements $OpenRouterRequestCopyWith<$Res> {
  _$OpenRouterRequestCopyWithImpl(this._self, this._then);

  final OpenRouterRequest _self;
  final $Res Function(OpenRouterRequest) _then;

/// Create a copy of OpenRouterRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? messages = null,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<OpenRouterMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenRouterRequest].
extension OpenRouterRequestPatterns on OpenRouterRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenRouterRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenRouterRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenRouterRequest value)  $default,){
final _that = this;
switch (_that) {
case _OpenRouterRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenRouterRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OpenRouterRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  List<OpenRouterMessage> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenRouterRequest() when $default != null:
return $default(_that.model,_that.messages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  List<OpenRouterMessage> messages)  $default,) {final _that = this;
switch (_that) {
case _OpenRouterRequest():
return $default(_that.model,_that.messages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  List<OpenRouterMessage> messages)?  $default,) {final _that = this;
switch (_that) {
case _OpenRouterRequest() when $default != null:
return $default(_that.model,_that.messages);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _OpenRouterRequest implements OpenRouterRequest {
  const _OpenRouterRequest({required this.model, required final  List<OpenRouterMessage> messages}): _messages = messages;
  factory _OpenRouterRequest.fromJson(Map<String, dynamic> json) => _$OpenRouterRequestFromJson(json);

@override final  String model;
 final  List<OpenRouterMessage> _messages;
@override List<OpenRouterMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of OpenRouterRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenRouterRequestCopyWith<_OpenRouterRequest> get copyWith => __$OpenRouterRequestCopyWithImpl<_OpenRouterRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenRouterRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenRouterRequest&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'OpenRouterRequest(model: $model, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$OpenRouterRequestCopyWith<$Res> implements $OpenRouterRequestCopyWith<$Res> {
  factory _$OpenRouterRequestCopyWith(_OpenRouterRequest value, $Res Function(_OpenRouterRequest) _then) = __$OpenRouterRequestCopyWithImpl;
@override @useResult
$Res call({
 String model, List<OpenRouterMessage> messages
});




}
/// @nodoc
class __$OpenRouterRequestCopyWithImpl<$Res>
    implements _$OpenRouterRequestCopyWith<$Res> {
  __$OpenRouterRequestCopyWithImpl(this._self, this._then);

  final _OpenRouterRequest _self;
  final $Res Function(_OpenRouterRequest) _then;

/// Create a copy of OpenRouterRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? messages = null,}) {
  return _then(_OpenRouterRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<OpenRouterMessage>,
  ));
}


}


/// @nodoc
mixin _$OpenRouterMessage {

 String get role; String get content;
/// Create a copy of OpenRouterMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenRouterMessageCopyWith<OpenRouterMessage> get copyWith => _$OpenRouterMessageCopyWithImpl<OpenRouterMessage>(this as OpenRouterMessage, _$identity);

  /// Serializes this OpenRouterMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenRouterMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'OpenRouterMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $OpenRouterMessageCopyWith<$Res>  {
  factory $OpenRouterMessageCopyWith(OpenRouterMessage value, $Res Function(OpenRouterMessage) _then) = _$OpenRouterMessageCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$OpenRouterMessageCopyWithImpl<$Res>
    implements $OpenRouterMessageCopyWith<$Res> {
  _$OpenRouterMessageCopyWithImpl(this._self, this._then);

  final OpenRouterMessage _self;
  final $Res Function(OpenRouterMessage) _then;

/// Create a copy of OpenRouterMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenRouterMessage].
extension OpenRouterMessagePatterns on OpenRouterMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenRouterMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenRouterMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenRouterMessage value)  $default,){
final _that = this;
switch (_that) {
case _OpenRouterMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenRouterMessage value)?  $default,){
final _that = this;
switch (_that) {
case _OpenRouterMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenRouterMessage() when $default != null:
return $default(_that.role,_that.content);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String content)  $default,) {final _that = this;
switch (_that) {
case _OpenRouterMessage():
return $default(_that.role,_that.content);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String content)?  $default,) {final _that = this;
switch (_that) {
case _OpenRouterMessage() when $default != null:
return $default(_that.role,_that.content);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _OpenRouterMessage implements OpenRouterMessage {
  const _OpenRouterMessage({required this.role, required this.content});
  factory _OpenRouterMessage.fromJson(Map<String, dynamic> json) => _$OpenRouterMessageFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of OpenRouterMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenRouterMessageCopyWith<_OpenRouterMessage> get copyWith => __$OpenRouterMessageCopyWithImpl<_OpenRouterMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenRouterMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenRouterMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'OpenRouterMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$OpenRouterMessageCopyWith<$Res> implements $OpenRouterMessageCopyWith<$Res> {
  factory _$OpenRouterMessageCopyWith(_OpenRouterMessage value, $Res Function(_OpenRouterMessage) _then) = __$OpenRouterMessageCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$OpenRouterMessageCopyWithImpl<$Res>
    implements _$OpenRouterMessageCopyWith<$Res> {
  __$OpenRouterMessageCopyWithImpl(this._self, this._then);

  final _OpenRouterMessage _self;
  final $Res Function(_OpenRouterMessage) _then;

/// Create a copy of OpenRouterMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_OpenRouterMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
