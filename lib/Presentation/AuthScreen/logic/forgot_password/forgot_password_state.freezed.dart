// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<T,$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState<T> _, $Res Function(ForgotPasswordState<T>) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns<T> on ForgotPasswordState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( SendOtpLoading<T> value)?  sendOtpLoading,TResult Function( SendOtpSuccess<T> value)?  sendOtpSuccess,TResult Function( SendOtpError<T> value)?  sendOtpError,TResult Function( VerifyOtpLoading<T> value)?  verifyOtpLoading,TResult Function( VerifyOtpSuccess<T> value)?  verifyOtpSuccess,TResult Function( VerifyOtpError<T> value)?  verifyOtpError,TResult Function( ResetPasswordLoading<T> value)?  resetPasswordLoading,TResult Function( ResetPasswordSuccess<T> value)?  resetPasswordSuccess,TResult Function( ResetPasswordError<T> value)?  resetPasswordError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SendOtpLoading() when sendOtpLoading != null:
return sendOtpLoading(_that);case SendOtpSuccess() when sendOtpSuccess != null:
return sendOtpSuccess(_that);case SendOtpError() when sendOtpError != null:
return sendOtpError(_that);case VerifyOtpLoading() when verifyOtpLoading != null:
return verifyOtpLoading(_that);case VerifyOtpSuccess() when verifyOtpSuccess != null:
return verifyOtpSuccess(_that);case VerifyOtpError() when verifyOtpError != null:
return verifyOtpError(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( SendOtpLoading<T> value)  sendOtpLoading,required TResult Function( SendOtpSuccess<T> value)  sendOtpSuccess,required TResult Function( SendOtpError<T> value)  sendOtpError,required TResult Function( VerifyOtpLoading<T> value)  verifyOtpLoading,required TResult Function( VerifyOtpSuccess<T> value)  verifyOtpSuccess,required TResult Function( VerifyOtpError<T> value)  verifyOtpError,required TResult Function( ResetPasswordLoading<T> value)  resetPasswordLoading,required TResult Function( ResetPasswordSuccess<T> value)  resetPasswordSuccess,required TResult Function( ResetPasswordError<T> value)  resetPasswordError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case SendOtpLoading():
return sendOtpLoading(_that);case SendOtpSuccess():
return sendOtpSuccess(_that);case SendOtpError():
return sendOtpError(_that);case VerifyOtpLoading():
return verifyOtpLoading(_that);case VerifyOtpSuccess():
return verifyOtpSuccess(_that);case VerifyOtpError():
return verifyOtpError(_that);case ResetPasswordLoading():
return resetPasswordLoading(_that);case ResetPasswordSuccess():
return resetPasswordSuccess(_that);case ResetPasswordError():
return resetPasswordError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( SendOtpLoading<T> value)?  sendOtpLoading,TResult? Function( SendOtpSuccess<T> value)?  sendOtpSuccess,TResult? Function( SendOtpError<T> value)?  sendOtpError,TResult? Function( VerifyOtpLoading<T> value)?  verifyOtpLoading,TResult? Function( VerifyOtpSuccess<T> value)?  verifyOtpSuccess,TResult? Function( VerifyOtpError<T> value)?  verifyOtpError,TResult? Function( ResetPasswordLoading<T> value)?  resetPasswordLoading,TResult? Function( ResetPasswordSuccess<T> value)?  resetPasswordSuccess,TResult? Function( ResetPasswordError<T> value)?  resetPasswordError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SendOtpLoading() when sendOtpLoading != null:
return sendOtpLoading(_that);case SendOtpSuccess() when sendOtpSuccess != null:
return sendOtpSuccess(_that);case SendOtpError() when sendOtpError != null:
return sendOtpError(_that);case VerifyOtpLoading() when verifyOtpLoading != null:
return verifyOtpLoading(_that);case VerifyOtpSuccess() when verifyOtpSuccess != null:
return verifyOtpSuccess(_that);case VerifyOtpError() when verifyOtpError != null:
return verifyOtpError(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  sendOtpLoading,TResult Function( T data)?  sendOtpSuccess,TResult Function( String message)?  sendOtpError,TResult Function()?  verifyOtpLoading,TResult Function( T data)?  verifyOtpSuccess,TResult Function( String message)?  verifyOtpError,TResult Function()?  resetPasswordLoading,TResult Function( T data)?  resetPasswordSuccess,TResult Function( String message)?  resetPasswordError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendOtpLoading() when sendOtpLoading != null:
return sendOtpLoading();case SendOtpSuccess() when sendOtpSuccess != null:
return sendOtpSuccess(_that.data);case SendOtpError() when sendOtpError != null:
return sendOtpError(_that.message);case VerifyOtpLoading() when verifyOtpLoading != null:
return verifyOtpLoading();case VerifyOtpSuccess() when verifyOtpSuccess != null:
return verifyOtpSuccess(_that.data);case VerifyOtpError() when verifyOtpError != null:
return verifyOtpError(_that.message);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  sendOtpLoading,required TResult Function( T data)  sendOtpSuccess,required TResult Function( String message)  sendOtpError,required TResult Function()  verifyOtpLoading,required TResult Function( T data)  verifyOtpSuccess,required TResult Function( String message)  verifyOtpError,required TResult Function()  resetPasswordLoading,required TResult Function( T data)  resetPasswordSuccess,required TResult Function( String message)  resetPasswordError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case SendOtpLoading():
return sendOtpLoading();case SendOtpSuccess():
return sendOtpSuccess(_that.data);case SendOtpError():
return sendOtpError(_that.message);case VerifyOtpLoading():
return verifyOtpLoading();case VerifyOtpSuccess():
return verifyOtpSuccess(_that.data);case VerifyOtpError():
return verifyOtpError(_that.message);case ResetPasswordLoading():
return resetPasswordLoading();case ResetPasswordSuccess():
return resetPasswordSuccess(_that.data);case ResetPasswordError():
return resetPasswordError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  sendOtpLoading,TResult? Function( T data)?  sendOtpSuccess,TResult? Function( String message)?  sendOtpError,TResult? Function()?  verifyOtpLoading,TResult? Function( T data)?  verifyOtpSuccess,TResult? Function( String message)?  verifyOtpError,TResult? Function()?  resetPasswordLoading,TResult? Function( T data)?  resetPasswordSuccess,TResult? Function( String message)?  resetPasswordError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendOtpLoading() when sendOtpLoading != null:
return sendOtpLoading();case SendOtpSuccess() when sendOtpSuccess != null:
return sendOtpSuccess(_that.data);case SendOtpError() when sendOtpError != null:
return sendOtpError(_that.message);case VerifyOtpLoading() when verifyOtpLoading != null:
return verifyOtpLoading();case VerifyOtpSuccess() when verifyOtpSuccess != null:
return verifyOtpSuccess(_that.data);case VerifyOtpError() when verifyOtpError != null:
return verifyOtpError(_that.message);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements ForgotPasswordState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.initial()';
}


}




/// @nodoc


class SendOtpLoading<T> implements ForgotPasswordState<T> {
  const SendOtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendOtpLoading()';
}


}




/// @nodoc


class SendOtpSuccess<T> implements ForgotPasswordState<T> {
  const SendOtpSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpSuccessCopyWith<T, SendOtpSuccess<T>> get copyWith => _$SendOtpSuccessCopyWithImpl<T, SendOtpSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendOtpSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $SendOtpSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $SendOtpSuccessCopyWith(SendOtpSuccess<T> value, $Res Function(SendOtpSuccess<T>) _then) = _$SendOtpSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$SendOtpSuccessCopyWithImpl<T,$Res>
    implements $SendOtpSuccessCopyWith<T, $Res> {
  _$SendOtpSuccessCopyWithImpl(this._self, this._then);

  final SendOtpSuccess<T> _self;
  final $Res Function(SendOtpSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(SendOtpSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class SendOtpError<T> implements ForgotPasswordState<T> {
  const SendOtpError({required this.message});
  

 final  String message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpErrorCopyWith<T, SendOtpError<T>> get copyWith => _$SendOtpErrorCopyWithImpl<T, SendOtpError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendOtpError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SendOtpErrorCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $SendOtpErrorCopyWith(SendOtpError<T> value, $Res Function(SendOtpError<T>) _then) = _$SendOtpErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SendOtpErrorCopyWithImpl<T,$Res>
    implements $SendOtpErrorCopyWith<T, $Res> {
  _$SendOtpErrorCopyWithImpl(this._self, this._then);

  final SendOtpError<T> _self;
  final $Res Function(SendOtpError<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SendOtpError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyOtpLoading<T> implements ForgotPasswordState<T> {
  const VerifyOtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyOtpLoading()';
}


}




/// @nodoc


class VerifyOtpSuccess<T> implements ForgotPasswordState<T> {
  const VerifyOtpSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpSuccessCopyWith<T, VerifyOtpSuccess<T>> get copyWith => _$VerifyOtpSuccessCopyWithImpl<T, VerifyOtpSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyOtpSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $VerifyOtpSuccessCopyWith(VerifyOtpSuccess<T> value, $Res Function(VerifyOtpSuccess<T>) _then) = _$VerifyOtpSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$VerifyOtpSuccessCopyWithImpl<T,$Res>
    implements $VerifyOtpSuccessCopyWith<T, $Res> {
  _$VerifyOtpSuccessCopyWithImpl(this._self, this._then);

  final VerifyOtpSuccess<T> _self;
  final $Res Function(VerifyOtpSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(VerifyOtpSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class VerifyOtpError<T> implements ForgotPasswordState<T> {
  const VerifyOtpError({required this.message});
  

 final  String message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpErrorCopyWith<T, VerifyOtpError<T>> get copyWith => _$VerifyOtpErrorCopyWithImpl<T, VerifyOtpError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyOtpError(message: $message)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpErrorCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $VerifyOtpErrorCopyWith(VerifyOtpError<T> value, $Res Function(VerifyOtpError<T>) _then) = _$VerifyOtpErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VerifyOtpErrorCopyWithImpl<T,$Res>
    implements $VerifyOtpErrorCopyWith<T, $Res> {
  _$VerifyOtpErrorCopyWithImpl(this._self, this._then);

  final VerifyOtpError<T> _self;
  final $Res Function(VerifyOtpError<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VerifyOtpError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPasswordLoading<T> implements ForgotPasswordState<T> {
  const ResetPasswordLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordLoading()';
}


}




/// @nodoc


class ResetPasswordSuccess<T> implements ForgotPasswordState<T> {
  const ResetPasswordSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSuccessCopyWith<T, ResetPasswordSuccess<T>> get copyWith => _$ResetPasswordSuccessCopyWithImpl<T, ResetPasswordSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $ResetPasswordSuccessCopyWith(ResetPasswordSuccess<T> value, $Res Function(ResetPasswordSuccess<T>) _then) = _$ResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ResetPasswordSuccessCopyWithImpl<T,$Res>
    implements $ResetPasswordSuccessCopyWith<T, $Res> {
  _$ResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final ResetPasswordSuccess<T> _self;
  final $Res Function(ResetPasswordSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ResetPasswordSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ResetPasswordError<T> implements ForgotPasswordState<T> {
  const ResetPasswordError({required this.message});
  

 final  String message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordErrorCopyWith<T, ResetPasswordError<T>> get copyWith => _$ResetPasswordErrorCopyWithImpl<T, ResetPasswordError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordErrorCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $ResetPasswordErrorCopyWith(ResetPasswordError<T> value, $Res Function(ResetPasswordError<T>) _then) = _$ResetPasswordErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ResetPasswordErrorCopyWithImpl<T,$Res>
    implements $ResetPasswordErrorCopyWith<T, $Res> {
  _$ResetPasswordErrorCopyWithImpl(this._self, this._then);

  final ResetPasswordError<T> _self;
  final $Res Function(ResetPasswordError<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ResetPasswordError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
