// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_page_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingPageInfo {

 String get title; String get description; String get iconName;
/// Create a copy of OnboardingPageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingPageInfoCopyWith<OnboardingPageInfo> get copyWith => _$OnboardingPageInfoCopyWithImpl<OnboardingPageInfo>(this as OnboardingPageInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingPageInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,iconName);

@override
String toString() {
  return 'OnboardingPageInfo(title: $title, description: $description, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class $OnboardingPageInfoCopyWith<$Res>  {
  factory $OnboardingPageInfoCopyWith(OnboardingPageInfo value, $Res Function(OnboardingPageInfo) _then) = _$OnboardingPageInfoCopyWithImpl;
@useResult
$Res call({
 String title, String description, String iconName
});




}
/// @nodoc
class _$OnboardingPageInfoCopyWithImpl<$Res>
    implements $OnboardingPageInfoCopyWith<$Res> {
  _$OnboardingPageInfoCopyWithImpl(this._self, this._then);

  final OnboardingPageInfo _self;
  final $Res Function(OnboardingPageInfo) _then;

/// Create a copy of OnboardingPageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? iconName = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingPageInfo].
extension OnboardingPageInfoPatterns on OnboardingPageInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingPageInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingPageInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingPageInfo value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingPageInfo value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String iconName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingPageInfo() when $default != null:
return $default(_that.title,_that.description,_that.iconName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String iconName)  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageInfo():
return $default(_that.title,_that.description,_that.iconName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String iconName)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageInfo() when $default != null:
return $default(_that.title,_that.description,_that.iconName);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingPageInfo implements OnboardingPageInfo {
  const _OnboardingPageInfo({required this.title, required this.description, required this.iconName});
  

@override final  String title;
@override final  String description;
@override final  String iconName;

/// Create a copy of OnboardingPageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingPageInfoCopyWith<_OnboardingPageInfo> get copyWith => __$OnboardingPageInfoCopyWithImpl<_OnboardingPageInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingPageInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,iconName);

@override
String toString() {
  return 'OnboardingPageInfo(title: $title, description: $description, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class _$OnboardingPageInfoCopyWith<$Res> implements $OnboardingPageInfoCopyWith<$Res> {
  factory _$OnboardingPageInfoCopyWith(_OnboardingPageInfo value, $Res Function(_OnboardingPageInfo) _then) = __$OnboardingPageInfoCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String iconName
});




}
/// @nodoc
class __$OnboardingPageInfoCopyWithImpl<$Res>
    implements _$OnboardingPageInfoCopyWith<$Res> {
  __$OnboardingPageInfoCopyWithImpl(this._self, this._then);

  final _OnboardingPageInfo _self;
  final $Res Function(_OnboardingPageInfo) _then;

/// Create a copy of OnboardingPageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? iconName = null,}) {
  return _then(_OnboardingPageInfo(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
