// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_router_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenRouterResponse {

 List<OpenRouterChoice> get choices;
/// Create a copy of OpenRouterResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenRouterResponseCopyWith<OpenRouterResponse> get copyWith => _$OpenRouterResponseCopyWithImpl<OpenRouterResponse>(this as OpenRouterResponse, _$identity);

  /// Serializes this OpenRouterResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenRouterResponse&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'OpenRouterResponse(choices: $choices)';
}


}

/// @nodoc
abstract mixin class $OpenRouterResponseCopyWith<$Res>  {
  factory $OpenRouterResponseCopyWith(OpenRouterResponse value, $Res Function(OpenRouterResponse) _then) = _$OpenRouterResponseCopyWithImpl;
@useResult
$Res call({
 List<OpenRouterChoice> choices
});




}
/// @nodoc
class _$OpenRouterResponseCopyWithImpl<$Res>
    implements $OpenRouterResponseCopyWith<$Res> {
  _$OpenRouterResponseCopyWithImpl(this._self, this._then);

  final OpenRouterResponse _self;
  final $Res Function(OpenRouterResponse) _then;

/// Create a copy of OpenRouterResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choices = null,}) {
  return _then(_self.copyWith(
choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenRouterChoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenRouterResponse].
extension OpenRouterResponsePatterns on OpenRouterResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenRouterResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenRouterResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenRouterResponse value)  $default,){
final _that = this;
switch (_that) {
case _OpenRouterResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenRouterResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OpenRouterResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OpenRouterChoice> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenRouterResponse() when $default != null:
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OpenRouterChoice> choices)  $default,) {final _that = this;
switch (_that) {
case _OpenRouterResponse():
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OpenRouterChoice> choices)?  $default,) {final _that = this;
switch (_that) {
case _OpenRouterResponse() when $default != null:
return $default(_that.choices);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _OpenRouterResponse implements OpenRouterResponse {
  const _OpenRouterResponse({final  List<OpenRouterChoice> choices = const []}): _choices = choices;
  factory _OpenRouterResponse.fromJson(Map<String, dynamic> json) => _$OpenRouterResponseFromJson(json);

 final  List<OpenRouterChoice> _choices;
@override@JsonKey() List<OpenRouterChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of OpenRouterResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenRouterResponseCopyWith<_OpenRouterResponse> get copyWith => __$OpenRouterResponseCopyWithImpl<_OpenRouterResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenRouterResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenRouterResponse&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'OpenRouterResponse(choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$OpenRouterResponseCopyWith<$Res> implements $OpenRouterResponseCopyWith<$Res> {
  factory _$OpenRouterResponseCopyWith(_OpenRouterResponse value, $Res Function(_OpenRouterResponse) _then) = __$OpenRouterResponseCopyWithImpl;
@override @useResult
$Res call({
 List<OpenRouterChoice> choices
});




}
/// @nodoc
class __$OpenRouterResponseCopyWithImpl<$Res>
    implements _$OpenRouterResponseCopyWith<$Res> {
  __$OpenRouterResponseCopyWithImpl(this._self, this._then);

  final _OpenRouterResponse _self;
  final $Res Function(_OpenRouterResponse) _then;

/// Create a copy of OpenRouterResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choices = null,}) {
  return _then(_OpenRouterResponse(
choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenRouterChoice>,
  ));
}


}


/// @nodoc
mixin _$OpenRouterChoice {

 OpenRouterMessage get message;
/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenRouterChoiceCopyWith<OpenRouterChoice> get copyWith => _$OpenRouterChoiceCopyWithImpl<OpenRouterChoice>(this as OpenRouterChoice, _$identity);

  /// Serializes this OpenRouterChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenRouterChoice&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OpenRouterChoice(message: $message)';
}


}

/// @nodoc
abstract mixin class $OpenRouterChoiceCopyWith<$Res>  {
  factory $OpenRouterChoiceCopyWith(OpenRouterChoice value, $Res Function(OpenRouterChoice) _then) = _$OpenRouterChoiceCopyWithImpl;
@useResult
$Res call({
 OpenRouterMessage message
});


$OpenRouterMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$OpenRouterChoiceCopyWithImpl<$Res>
    implements $OpenRouterChoiceCopyWith<$Res> {
  _$OpenRouterChoiceCopyWithImpl(this._self, this._then);

  final OpenRouterChoice _self;
  final $Res Function(OpenRouterChoice) _then;

/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as OpenRouterMessage,
  ));
}
/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenRouterMessageCopyWith<$Res> get message {
  
  return $OpenRouterMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpenRouterChoice].
extension OpenRouterChoicePatterns on OpenRouterChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenRouterChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenRouterChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenRouterChoice value)  $default,){
final _that = this;
switch (_that) {
case _OpenRouterChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenRouterChoice value)?  $default,){
final _that = this;
switch (_that) {
case _OpenRouterChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OpenRouterMessage message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenRouterChoice() when $default != null:
return $default(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OpenRouterMessage message)  $default,) {final _that = this;
switch (_that) {
case _OpenRouterChoice():
return $default(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OpenRouterMessage message)?  $default,) {final _that = this;
switch (_that) {
case _OpenRouterChoice() when $default != null:
return $default(_that.message);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _OpenRouterChoice implements OpenRouterChoice {
  const _OpenRouterChoice({required this.message});
  factory _OpenRouterChoice.fromJson(Map<String, dynamic> json) => _$OpenRouterChoiceFromJson(json);

@override final  OpenRouterMessage message;

/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenRouterChoiceCopyWith<_OpenRouterChoice> get copyWith => __$OpenRouterChoiceCopyWithImpl<_OpenRouterChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenRouterChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenRouterChoice&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OpenRouterChoice(message: $message)';
}


}

/// @nodoc
abstract mixin class _$OpenRouterChoiceCopyWith<$Res> implements $OpenRouterChoiceCopyWith<$Res> {
  factory _$OpenRouterChoiceCopyWith(_OpenRouterChoice value, $Res Function(_OpenRouterChoice) _then) = __$OpenRouterChoiceCopyWithImpl;
@override @useResult
$Res call({
 OpenRouterMessage message
});


@override $OpenRouterMessageCopyWith<$Res> get message;

}
/// @nodoc
class __$OpenRouterChoiceCopyWithImpl<$Res>
    implements _$OpenRouterChoiceCopyWith<$Res> {
  __$OpenRouterChoiceCopyWithImpl(this._self, this._then);

  final _OpenRouterChoice _self;
  final $Res Function(_OpenRouterChoice) _then;

/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_OpenRouterChoice(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as OpenRouterMessage,
  ));
}

/// Create a copy of OpenRouterChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenRouterMessageCopyWith<$Res> get message {
  
  return $OpenRouterMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
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
