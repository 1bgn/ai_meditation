// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paywall_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaywallOffer {

 String get title; String get description; String get price;
/// Create a copy of PaywallOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaywallOfferCopyWith<PaywallOffer> get copyWith => _$PaywallOfferCopyWithImpl<PaywallOffer>(this as PaywallOffer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallOffer&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,price);

@override
String toString() {
  return 'PaywallOffer(title: $title, description: $description, price: $price)';
}


}

/// @nodoc
abstract mixin class $PaywallOfferCopyWith<$Res>  {
  factory $PaywallOfferCopyWith(PaywallOffer value, $Res Function(PaywallOffer) _then) = _$PaywallOfferCopyWithImpl;
@useResult
$Res call({
 String title, String description, String price
});




}
/// @nodoc
class _$PaywallOfferCopyWithImpl<$Res>
    implements $PaywallOfferCopyWith<$Res> {
  _$PaywallOfferCopyWithImpl(this._self, this._then);

  final PaywallOffer _self;
  final $Res Function(PaywallOffer) _then;

/// Create a copy of PaywallOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? price = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaywallOffer].
extension PaywallOfferPatterns on PaywallOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaywallOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaywallOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaywallOffer value)  $default,){
final _that = this;
switch (_that) {
case _PaywallOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaywallOffer value)?  $default,){
final _that = this;
switch (_that) {
case _PaywallOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaywallOffer() when $default != null:
return $default(_that.title,_that.description,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String price)  $default,) {final _that = this;
switch (_that) {
case _PaywallOffer():
return $default(_that.title,_that.description,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String price)?  $default,) {final _that = this;
switch (_that) {
case _PaywallOffer() when $default != null:
return $default(_that.title,_that.description,_that.price);case _:
  return null;

}
}

}

/// @nodoc


class _PaywallOffer implements PaywallOffer {
  const _PaywallOffer({required this.title, required this.description, required this.price});
  

@override final  String title;
@override final  String description;
@override final  String price;

/// Create a copy of PaywallOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaywallOfferCopyWith<_PaywallOffer> get copyWith => __$PaywallOfferCopyWithImpl<_PaywallOffer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaywallOffer&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,price);

@override
String toString() {
  return 'PaywallOffer(title: $title, description: $description, price: $price)';
}


}

/// @nodoc
abstract mixin class _$PaywallOfferCopyWith<$Res> implements $PaywallOfferCopyWith<$Res> {
  factory _$PaywallOfferCopyWith(_PaywallOffer value, $Res Function(_PaywallOffer) _then) = __$PaywallOfferCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String price
});




}
/// @nodoc
class __$PaywallOfferCopyWithImpl<$Res>
    implements _$PaywallOfferCopyWith<$Res> {
  __$PaywallOfferCopyWithImpl(this._self, this._then);

  final _PaywallOffer _self;
  final $Res Function(_PaywallOffer) _then;

/// Create a copy of PaywallOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? price = null,}) {
  return _then(_PaywallOffer(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
