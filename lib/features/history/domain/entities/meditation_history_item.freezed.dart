// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meditation_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeditationHistoryItem {

 String get id; String get title; int get durationMinutes;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(includeFromJson: true, includeToJson: false) DateTime? get updatedAt; bool get isDeleted;
/// Create a copy of MeditationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeditationHistoryItemCopyWith<MeditationHistoryItem> get copyWith => _$MeditationHistoryItemCopyWithImpl<MeditationHistoryItem>(this as MeditationHistoryItem, _$identity);

  /// Serializes this MeditationHistoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeditationHistoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,durationMinutes,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'MeditationHistoryItem(id: $id, title: $title, durationMinutes: $durationMinutes, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $MeditationHistoryItemCopyWith<$Res>  {
  factory $MeditationHistoryItemCopyWith(MeditationHistoryItem value, $Res Function(MeditationHistoryItem) _then) = _$MeditationHistoryItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, int durationMinutes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeFromJson: true, includeToJson: false) DateTime? updatedAt, bool isDeleted
});




}
/// @nodoc
class _$MeditationHistoryItemCopyWithImpl<$Res>
    implements $MeditationHistoryItemCopyWith<$Res> {
  _$MeditationHistoryItemCopyWithImpl(this._self, this._then);

  final MeditationHistoryItem _self;
  final $Res Function(MeditationHistoryItem) _then;

/// Create a copy of MeditationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? durationMinutes = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeditationHistoryItem].
extension MeditationHistoryItemPatterns on MeditationHistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeditationHistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeditationHistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeditationHistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _MeditationHistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeditationHistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _MeditationHistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int durationMinutes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeFromJson: true, includeToJson: false)  DateTime? updatedAt,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeditationHistoryItem() when $default != null:
return $default(_that.id,_that.title,_that.durationMinutes,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int durationMinutes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeFromJson: true, includeToJson: false)  DateTime? updatedAt,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _MeditationHistoryItem():
return $default(_that.id,_that.title,_that.durationMinutes,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int durationMinutes, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeFromJson: true, includeToJson: false)  DateTime? updatedAt,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _MeditationHistoryItem() when $default != null:
return $default(_that.id,_that.title,_that.durationMinutes,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _MeditationHistoryItem implements MeditationHistoryItem {
  const _MeditationHistoryItem({required this.id, required this.title, required this.durationMinutes, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(includeFromJson: true, includeToJson: false) this.updatedAt, this.isDeleted = false});
  factory _MeditationHistoryItem.fromJson(Map<String, dynamic> json) => _$MeditationHistoryItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  int durationMinutes;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(includeFromJson: true, includeToJson: false) final  DateTime? updatedAt;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of MeditationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeditationHistoryItemCopyWith<_MeditationHistoryItem> get copyWith => __$MeditationHistoryItemCopyWithImpl<_MeditationHistoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeditationHistoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeditationHistoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,durationMinutes,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'MeditationHistoryItem(id: $id, title: $title, durationMinutes: $durationMinutes, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$MeditationHistoryItemCopyWith<$Res> implements $MeditationHistoryItemCopyWith<$Res> {
  factory _$MeditationHistoryItemCopyWith(_MeditationHistoryItem value, $Res Function(_MeditationHistoryItem) _then) = __$MeditationHistoryItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int durationMinutes,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeFromJson: true, includeToJson: false) DateTime? updatedAt, bool isDeleted
});




}
/// @nodoc
class __$MeditationHistoryItemCopyWithImpl<$Res>
    implements _$MeditationHistoryItemCopyWith<$Res> {
  __$MeditationHistoryItemCopyWithImpl(this._self, this._then);

  final _MeditationHistoryItem _self;
  final $Res Function(_MeditationHistoryItem) _then;

/// Create a copy of MeditationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? durationMinutes = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,}) {
  return _then(_MeditationHistoryItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
