// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breathing_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BreathingOptions {

 String get mood; int get durationMinutes;
/// Create a copy of BreathingOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BreathingOptionsCopyWith<BreathingOptions> get copyWith => _$BreathingOptionsCopyWithImpl<BreathingOptions>(this as BreathingOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreathingOptions&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,mood,durationMinutes);

@override
String toString() {
  return 'BreathingOptions(mood: $mood, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $BreathingOptionsCopyWith<$Res>  {
  factory $BreathingOptionsCopyWith(BreathingOptions value, $Res Function(BreathingOptions) _then) = _$BreathingOptionsCopyWithImpl;
@useResult
$Res call({
 String mood, int durationMinutes
});




}
/// @nodoc
class _$BreathingOptionsCopyWithImpl<$Res>
    implements $BreathingOptionsCopyWith<$Res> {
  _$BreathingOptionsCopyWithImpl(this._self, this._then);

  final BreathingOptions _self;
  final $Res Function(BreathingOptions) _then;

/// Create a copy of BreathingOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mood = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BreathingOptions].
extension BreathingOptionsPatterns on BreathingOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BreathingOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BreathingOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BreathingOptions value)  $default,){
final _that = this;
switch (_that) {
case _BreathingOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BreathingOptions value)?  $default,){
final _that = this;
switch (_that) {
case _BreathingOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mood,  int durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BreathingOptions() when $default != null:
return $default(_that.mood,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mood,  int durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _BreathingOptions():
return $default(_that.mood,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mood,  int durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _BreathingOptions() when $default != null:
return $default(_that.mood,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _BreathingOptions implements BreathingOptions {
  const _BreathingOptions({required this.mood, required this.durationMinutes});
  

@override final  String mood;
@override final  int durationMinutes;

/// Create a copy of BreathingOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BreathingOptionsCopyWith<_BreathingOptions> get copyWith => __$BreathingOptionsCopyWithImpl<_BreathingOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BreathingOptions&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,mood,durationMinutes);

@override
String toString() {
  return 'BreathingOptions(mood: $mood, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$BreathingOptionsCopyWith<$Res> implements $BreathingOptionsCopyWith<$Res> {
  factory _$BreathingOptionsCopyWith(_BreathingOptions value, $Res Function(_BreathingOptions) _then) = __$BreathingOptionsCopyWithImpl;
@override @useResult
$Res call({
 String mood, int durationMinutes
});




}
/// @nodoc
class __$BreathingOptionsCopyWithImpl<$Res>
    implements _$BreathingOptionsCopyWith<$Res> {
  __$BreathingOptionsCopyWithImpl(this._self, this._then);

  final _BreathingOptions _self;
  final $Res Function(_BreathingOptions) _then;

/// Create a copy of BreathingOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mood = null,Object? durationMinutes = null,}) {
  return _then(_BreathingOptions(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
