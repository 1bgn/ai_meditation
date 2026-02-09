// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_routine_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyRoutineItem {

 String get title; String get description; int get durationMinutes;
/// Create a copy of DailyRoutineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyRoutineItemCopyWith<DailyRoutineItem> get copyWith => _$DailyRoutineItemCopyWithImpl<DailyRoutineItem>(this as DailyRoutineItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyRoutineItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,durationMinutes);

@override
String toString() {
  return 'DailyRoutineItem(title: $title, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $DailyRoutineItemCopyWith<$Res>  {
  factory $DailyRoutineItemCopyWith(DailyRoutineItem value, $Res Function(DailyRoutineItem) _then) = _$DailyRoutineItemCopyWithImpl;
@useResult
$Res call({
 String title, String description, int durationMinutes
});




}
/// @nodoc
class _$DailyRoutineItemCopyWithImpl<$Res>
    implements $DailyRoutineItemCopyWith<$Res> {
  _$DailyRoutineItemCopyWithImpl(this._self, this._then);

  final DailyRoutineItem _self;
  final $Res Function(DailyRoutineItem) _then;

/// Create a copy of DailyRoutineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyRoutineItem].
extension DailyRoutineItemPatterns on DailyRoutineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyRoutineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyRoutineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyRoutineItem value)  $default,){
final _that = this;
switch (_that) {
case _DailyRoutineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyRoutineItem value)?  $default,){
final _that = this;
switch (_that) {
case _DailyRoutineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  int durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyRoutineItem() when $default != null:
return $default(_that.title,_that.description,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  int durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _DailyRoutineItem():
return $default(_that.title,_that.description,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  int durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _DailyRoutineItem() when $default != null:
return $default(_that.title,_that.description,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _DailyRoutineItem implements DailyRoutineItem {
  const _DailyRoutineItem({required this.title, required this.description, required this.durationMinutes});
  

@override final  String title;
@override final  String description;
@override final  int durationMinutes;

/// Create a copy of DailyRoutineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyRoutineItemCopyWith<_DailyRoutineItem> get copyWith => __$DailyRoutineItemCopyWithImpl<_DailyRoutineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyRoutineItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,durationMinutes);

@override
String toString() {
  return 'DailyRoutineItem(title: $title, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$DailyRoutineItemCopyWith<$Res> implements $DailyRoutineItemCopyWith<$Res> {
  factory _$DailyRoutineItemCopyWith(_DailyRoutineItem value, $Res Function(_DailyRoutineItem) _then) = __$DailyRoutineItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, int durationMinutes
});




}
/// @nodoc
class __$DailyRoutineItemCopyWithImpl<$Res>
    implements _$DailyRoutineItemCopyWith<$Res> {
  __$DailyRoutineItemCopyWithImpl(this._self, this._then);

  final _DailyRoutineItem _self;
  final $Res Function(_DailyRoutineItem) _then;

/// Create a copy of DailyRoutineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_DailyRoutineItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
