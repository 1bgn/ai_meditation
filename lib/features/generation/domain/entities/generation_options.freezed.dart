// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerationOptions {

 String get goal; int get durationMinutes; String get voiceStyle; String get backgroundSound;
/// Create a copy of GenerationOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationOptionsCopyWith<GenerationOptions> get copyWith => _$GenerationOptionsCopyWithImpl<GenerationOptions>(this as GenerationOptions, _$identity);

  /// Serializes this GenerationOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationOptions&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.voiceStyle, voiceStyle) || other.voiceStyle == voiceStyle)&&(identical(other.backgroundSound, backgroundSound) || other.backgroundSound == backgroundSound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goal,durationMinutes,voiceStyle,backgroundSound);

@override
String toString() {
  return 'GenerationOptions(goal: $goal, durationMinutes: $durationMinutes, voiceStyle: $voiceStyle, backgroundSound: $backgroundSound)';
}


}

/// @nodoc
abstract mixin class $GenerationOptionsCopyWith<$Res>  {
  factory $GenerationOptionsCopyWith(GenerationOptions value, $Res Function(GenerationOptions) _then) = _$GenerationOptionsCopyWithImpl;
@useResult
$Res call({
 String goal, int durationMinutes, String voiceStyle, String backgroundSound
});




}
/// @nodoc
class _$GenerationOptionsCopyWithImpl<$Res>
    implements $GenerationOptionsCopyWith<$Res> {
  _$GenerationOptionsCopyWithImpl(this._self, this._then);

  final GenerationOptions _self;
  final $Res Function(GenerationOptions) _then;

/// Create a copy of GenerationOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goal = null,Object? durationMinutes = null,Object? voiceStyle = null,Object? backgroundSound = null,}) {
  return _then(_self.copyWith(
goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,voiceStyle: null == voiceStyle ? _self.voiceStyle : voiceStyle // ignore: cast_nullable_to_non_nullable
as String,backgroundSound: null == backgroundSound ? _self.backgroundSound : backgroundSound // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerationOptions].
extension GenerationOptionsPatterns on GenerationOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationOptions value)  $default,){
final _that = this;
switch (_that) {
case _GenerationOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationOptions value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String goal,  int durationMinutes,  String voiceStyle,  String backgroundSound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationOptions() when $default != null:
return $default(_that.goal,_that.durationMinutes,_that.voiceStyle,_that.backgroundSound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String goal,  int durationMinutes,  String voiceStyle,  String backgroundSound)  $default,) {final _that = this;
switch (_that) {
case _GenerationOptions():
return $default(_that.goal,_that.durationMinutes,_that.voiceStyle,_that.backgroundSound);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String goal,  int durationMinutes,  String voiceStyle,  String backgroundSound)?  $default,) {final _that = this;
switch (_that) {
case _GenerationOptions() when $default != null:
return $default(_that.goal,_that.durationMinutes,_that.voiceStyle,_that.backgroundSound);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _GenerationOptions implements GenerationOptions {
  const _GenerationOptions({required this.goal, required this.durationMinutes, required this.voiceStyle, required this.backgroundSound});
  factory _GenerationOptions.fromJson(Map<String, dynamic> json) => _$GenerationOptionsFromJson(json);

@override final  String goal;
@override final  int durationMinutes;
@override final  String voiceStyle;
@override final  String backgroundSound;

/// Create a copy of GenerationOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationOptionsCopyWith<_GenerationOptions> get copyWith => __$GenerationOptionsCopyWithImpl<_GenerationOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerationOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationOptions&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.voiceStyle, voiceStyle) || other.voiceStyle == voiceStyle)&&(identical(other.backgroundSound, backgroundSound) || other.backgroundSound == backgroundSound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goal,durationMinutes,voiceStyle,backgroundSound);

@override
String toString() {
  return 'GenerationOptions(goal: $goal, durationMinutes: $durationMinutes, voiceStyle: $voiceStyle, backgroundSound: $backgroundSound)';
}


}

/// @nodoc
abstract mixin class _$GenerationOptionsCopyWith<$Res> implements $GenerationOptionsCopyWith<$Res> {
  factory _$GenerationOptionsCopyWith(_GenerationOptions value, $Res Function(_GenerationOptions) _then) = __$GenerationOptionsCopyWithImpl;
@override @useResult
$Res call({
 String goal, int durationMinutes, String voiceStyle, String backgroundSound
});




}
/// @nodoc
class __$GenerationOptionsCopyWithImpl<$Res>
    implements _$GenerationOptionsCopyWith<$Res> {
  __$GenerationOptionsCopyWithImpl(this._self, this._then);

  final _GenerationOptions _self;
  final $Res Function(_GenerationOptions) _then;

/// Create a copy of GenerationOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goal = null,Object? durationMinutes = null,Object? voiceStyle = null,Object? backgroundSound = null,}) {
  return _then(_GenerationOptions(
goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,voiceStyle: null == voiceStyle ? _self.voiceStyle : voiceStyle // ignore: cast_nullable_to_non_nullable
as String,backgroundSound: null == backgroundSound ? _self.backgroundSound : backgroundSound // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
