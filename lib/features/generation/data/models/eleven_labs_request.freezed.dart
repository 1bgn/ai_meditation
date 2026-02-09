// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eleven_labs_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElevenLabsRequest {

 String get text; String get modelId; ElevenLabsVoiceSettings get voiceSettings;
/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElevenLabsRequestCopyWith<ElevenLabsRequest> get copyWith => _$ElevenLabsRequestCopyWithImpl<ElevenLabsRequest>(this as ElevenLabsRequest, _$identity);

  /// Serializes this ElevenLabsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElevenLabsRequest&&(identical(other.text, text) || other.text == text)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.voiceSettings, voiceSettings) || other.voiceSettings == voiceSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,modelId,voiceSettings);

@override
String toString() {
  return 'ElevenLabsRequest(text: $text, modelId: $modelId, voiceSettings: $voiceSettings)';
}


}

/// @nodoc
abstract mixin class $ElevenLabsRequestCopyWith<$Res>  {
  factory $ElevenLabsRequestCopyWith(ElevenLabsRequest value, $Res Function(ElevenLabsRequest) _then) = _$ElevenLabsRequestCopyWithImpl;
@useResult
$Res call({
 String text, String modelId, ElevenLabsVoiceSettings voiceSettings
});


$ElevenLabsVoiceSettingsCopyWith<$Res> get voiceSettings;

}
/// @nodoc
class _$ElevenLabsRequestCopyWithImpl<$Res>
    implements $ElevenLabsRequestCopyWith<$Res> {
  _$ElevenLabsRequestCopyWithImpl(this._self, this._then);

  final ElevenLabsRequest _self;
  final $Res Function(ElevenLabsRequest) _then;

/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? modelId = null,Object? voiceSettings = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,voiceSettings: null == voiceSettings ? _self.voiceSettings : voiceSettings // ignore: cast_nullable_to_non_nullable
as ElevenLabsVoiceSettings,
  ));
}
/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElevenLabsVoiceSettingsCopyWith<$Res> get voiceSettings {
  
  return $ElevenLabsVoiceSettingsCopyWith<$Res>(_self.voiceSettings, (value) {
    return _then(_self.copyWith(voiceSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [ElevenLabsRequest].
extension ElevenLabsRequestPatterns on ElevenLabsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElevenLabsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElevenLabsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElevenLabsRequest value)  $default,){
final _that = this;
switch (_that) {
case _ElevenLabsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElevenLabsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ElevenLabsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String modelId,  ElevenLabsVoiceSettings voiceSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElevenLabsRequest() when $default != null:
return $default(_that.text,_that.modelId,_that.voiceSettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String modelId,  ElevenLabsVoiceSettings voiceSettings)  $default,) {final _that = this;
switch (_that) {
case _ElevenLabsRequest():
return $default(_that.text,_that.modelId,_that.voiceSettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String modelId,  ElevenLabsVoiceSettings voiceSettings)?  $default,) {final _that = this;
switch (_that) {
case _ElevenLabsRequest() when $default != null:
return $default(_that.text,_that.modelId,_that.voiceSettings);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ElevenLabsRequest implements ElevenLabsRequest {
  const _ElevenLabsRequest({required this.text, required this.modelId, required this.voiceSettings});
  factory _ElevenLabsRequest.fromJson(Map<String, dynamic> json) => _$ElevenLabsRequestFromJson(json);

@override final  String text;
@override final  String modelId;
@override final  ElevenLabsVoiceSettings voiceSettings;

/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElevenLabsRequestCopyWith<_ElevenLabsRequest> get copyWith => __$ElevenLabsRequestCopyWithImpl<_ElevenLabsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElevenLabsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElevenLabsRequest&&(identical(other.text, text) || other.text == text)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.voiceSettings, voiceSettings) || other.voiceSettings == voiceSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,modelId,voiceSettings);

@override
String toString() {
  return 'ElevenLabsRequest(text: $text, modelId: $modelId, voiceSettings: $voiceSettings)';
}


}

/// @nodoc
abstract mixin class _$ElevenLabsRequestCopyWith<$Res> implements $ElevenLabsRequestCopyWith<$Res> {
  factory _$ElevenLabsRequestCopyWith(_ElevenLabsRequest value, $Res Function(_ElevenLabsRequest) _then) = __$ElevenLabsRequestCopyWithImpl;
@override @useResult
$Res call({
 String text, String modelId, ElevenLabsVoiceSettings voiceSettings
});


@override $ElevenLabsVoiceSettingsCopyWith<$Res> get voiceSettings;

}
/// @nodoc
class __$ElevenLabsRequestCopyWithImpl<$Res>
    implements _$ElevenLabsRequestCopyWith<$Res> {
  __$ElevenLabsRequestCopyWithImpl(this._self, this._then);

  final _ElevenLabsRequest _self;
  final $Res Function(_ElevenLabsRequest) _then;

/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? modelId = null,Object? voiceSettings = null,}) {
  return _then(_ElevenLabsRequest(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,voiceSettings: null == voiceSettings ? _self.voiceSettings : voiceSettings // ignore: cast_nullable_to_non_nullable
as ElevenLabsVoiceSettings,
  ));
}

/// Create a copy of ElevenLabsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElevenLabsVoiceSettingsCopyWith<$Res> get voiceSettings {
  
  return $ElevenLabsVoiceSettingsCopyWith<$Res>(_self.voiceSettings, (value) {
    return _then(_self.copyWith(voiceSettings: value));
  });
}
}


/// @nodoc
mixin _$ElevenLabsVoiceSettings {

 double get stability; double get similarityBoost;
/// Create a copy of ElevenLabsVoiceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElevenLabsVoiceSettingsCopyWith<ElevenLabsVoiceSettings> get copyWith => _$ElevenLabsVoiceSettingsCopyWithImpl<ElevenLabsVoiceSettings>(this as ElevenLabsVoiceSettings, _$identity);

  /// Serializes this ElevenLabsVoiceSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElevenLabsVoiceSettings&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.similarityBoost, similarityBoost) || other.similarityBoost == similarityBoost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stability,similarityBoost);

@override
String toString() {
  return 'ElevenLabsVoiceSettings(stability: $stability, similarityBoost: $similarityBoost)';
}


}

/// @nodoc
abstract mixin class $ElevenLabsVoiceSettingsCopyWith<$Res>  {
  factory $ElevenLabsVoiceSettingsCopyWith(ElevenLabsVoiceSettings value, $Res Function(ElevenLabsVoiceSettings) _then) = _$ElevenLabsVoiceSettingsCopyWithImpl;
@useResult
$Res call({
 double stability, double similarityBoost
});




}
/// @nodoc
class _$ElevenLabsVoiceSettingsCopyWithImpl<$Res>
    implements $ElevenLabsVoiceSettingsCopyWith<$Res> {
  _$ElevenLabsVoiceSettingsCopyWithImpl(this._self, this._then);

  final ElevenLabsVoiceSettings _self;
  final $Res Function(ElevenLabsVoiceSettings) _then;

/// Create a copy of ElevenLabsVoiceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stability = null,Object? similarityBoost = null,}) {
  return _then(_self.copyWith(
stability: null == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double,similarityBoost: null == similarityBoost ? _self.similarityBoost : similarityBoost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ElevenLabsVoiceSettings].
extension ElevenLabsVoiceSettingsPatterns on ElevenLabsVoiceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElevenLabsVoiceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElevenLabsVoiceSettings value)  $default,){
final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElevenLabsVoiceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double stability,  double similarityBoost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings() when $default != null:
return $default(_that.stability,_that.similarityBoost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double stability,  double similarityBoost)  $default,) {final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings():
return $default(_that.stability,_that.similarityBoost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double stability,  double similarityBoost)?  $default,) {final _that = this;
switch (_that) {
case _ElevenLabsVoiceSettings() when $default != null:
return $default(_that.stability,_that.similarityBoost);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ElevenLabsVoiceSettings implements ElevenLabsVoiceSettings {
  const _ElevenLabsVoiceSettings({required this.stability, required this.similarityBoost});
  factory _ElevenLabsVoiceSettings.fromJson(Map<String, dynamic> json) => _$ElevenLabsVoiceSettingsFromJson(json);

@override final  double stability;
@override final  double similarityBoost;

/// Create a copy of ElevenLabsVoiceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElevenLabsVoiceSettingsCopyWith<_ElevenLabsVoiceSettings> get copyWith => __$ElevenLabsVoiceSettingsCopyWithImpl<_ElevenLabsVoiceSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElevenLabsVoiceSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElevenLabsVoiceSettings&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.similarityBoost, similarityBoost) || other.similarityBoost == similarityBoost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stability,similarityBoost);

@override
String toString() {
  return 'ElevenLabsVoiceSettings(stability: $stability, similarityBoost: $similarityBoost)';
}


}

/// @nodoc
abstract mixin class _$ElevenLabsVoiceSettingsCopyWith<$Res> implements $ElevenLabsVoiceSettingsCopyWith<$Res> {
  factory _$ElevenLabsVoiceSettingsCopyWith(_ElevenLabsVoiceSettings value, $Res Function(_ElevenLabsVoiceSettings) _then) = __$ElevenLabsVoiceSettingsCopyWithImpl;
@override @useResult
$Res call({
 double stability, double similarityBoost
});




}
/// @nodoc
class __$ElevenLabsVoiceSettingsCopyWithImpl<$Res>
    implements _$ElevenLabsVoiceSettingsCopyWith<$Res> {
  __$ElevenLabsVoiceSettingsCopyWithImpl(this._self, this._then);

  final _ElevenLabsVoiceSettings _self;
  final $Res Function(_ElevenLabsVoiceSettings) _then;

/// Create a copy of ElevenLabsVoiceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stability = null,Object? similarityBoost = null,}) {
  return _then(_ElevenLabsVoiceSettings(
stability: null == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double,similarityBoost: null == similarityBoost ? _self.similarityBoost : similarityBoost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
