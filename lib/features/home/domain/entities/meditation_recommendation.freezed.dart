// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meditation_recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeditationRecommendation {

 String get title; String get subtitle; int get durationMinutes;
/// Create a copy of MeditationRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeditationRecommendationCopyWith<MeditationRecommendation> get copyWith => _$MeditationRecommendationCopyWithImpl<MeditationRecommendation>(this as MeditationRecommendation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeditationRecommendation&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,durationMinutes);

@override
String toString() {
  return 'MeditationRecommendation(title: $title, subtitle: $subtitle, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $MeditationRecommendationCopyWith<$Res>  {
  factory $MeditationRecommendationCopyWith(MeditationRecommendation value, $Res Function(MeditationRecommendation) _then) = _$MeditationRecommendationCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle, int durationMinutes
});




}
/// @nodoc
class _$MeditationRecommendationCopyWithImpl<$Res>
    implements $MeditationRecommendationCopyWith<$Res> {
  _$MeditationRecommendationCopyWithImpl(this._self, this._then);

  final MeditationRecommendation _self;
  final $Res Function(MeditationRecommendation) _then;

/// Create a copy of MeditationRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MeditationRecommendation].
extension MeditationRecommendationPatterns on MeditationRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeditationRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeditationRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeditationRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _MeditationRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeditationRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _MeditationRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle,  int durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeditationRecommendation() when $default != null:
return $default(_that.title,_that.subtitle,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle,  int durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _MeditationRecommendation():
return $default(_that.title,_that.subtitle,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle,  int durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _MeditationRecommendation() when $default != null:
return $default(_that.title,_that.subtitle,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _MeditationRecommendation implements MeditationRecommendation {
  const _MeditationRecommendation({required this.title, required this.subtitle, required this.durationMinutes});
  

@override final  String title;
@override final  String subtitle;
@override final  int durationMinutes;

/// Create a copy of MeditationRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeditationRecommendationCopyWith<_MeditationRecommendation> get copyWith => __$MeditationRecommendationCopyWithImpl<_MeditationRecommendation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeditationRecommendation&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,durationMinutes);

@override
String toString() {
  return 'MeditationRecommendation(title: $title, subtitle: $subtitle, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$MeditationRecommendationCopyWith<$Res> implements $MeditationRecommendationCopyWith<$Res> {
  factory _$MeditationRecommendationCopyWith(_MeditationRecommendation value, $Res Function(_MeditationRecommendation) _then) = __$MeditationRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle, int durationMinutes
});




}
/// @nodoc
class __$MeditationRecommendationCopyWithImpl<$Res>
    implements _$MeditationRecommendationCopyWith<$Res> {
  __$MeditationRecommendationCopyWithImpl(this._self, this._then);

  final _MeditationRecommendation _self;
  final $Res Function(_MeditationRecommendation) _then;

/// Create a copy of MeditationRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? durationMinutes = null,}) {
  return _then(_MeditationRecommendation(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
