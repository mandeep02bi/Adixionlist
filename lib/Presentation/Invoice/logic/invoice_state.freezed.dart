// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvoiceState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InvoiceState<$T>()';
}


}

/// @nodoc
class $InvoiceStateCopyWith<T,$Res>  {
$InvoiceStateCopyWith(InvoiceState<T> _, $Res Function(InvoiceState<T>) __);
}


/// Adds pattern-matching-related methods to [InvoiceState].
extension InvoiceStatePatterns<T> on InvoiceState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( Loading<T> value)?  loading,TResult Function( FetchInvoicesSuccess<T> value)?  fetchInvoicesSuccess,TResult Function( FetchInvoicesError<T> value)?  fetchInvoicesError,TResult Function( CreateInvoiceSuccess<T> value)?  createInvoiceSuccess,TResult Function( CreateInvoiceError<T> value)?  createInvoiceError,TResult Function( FetchPatientsSuccess<T> value)?  fetchPatientsSuccess,TResult Function( FetchPatientsError<T> value)?  fetchPatientsError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case FetchInvoicesSuccess() when fetchInvoicesSuccess != null:
return fetchInvoicesSuccess(_that);case FetchInvoicesError() when fetchInvoicesError != null:
return fetchInvoicesError(_that);case CreateInvoiceSuccess() when createInvoiceSuccess != null:
return createInvoiceSuccess(_that);case CreateInvoiceError() when createInvoiceError != null:
return createInvoiceError(_that);case FetchPatientsSuccess() when fetchPatientsSuccess != null:
return fetchPatientsSuccess(_that);case FetchPatientsError() when fetchPatientsError != null:
return fetchPatientsError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( Loading<T> value)  loading,required TResult Function( FetchInvoicesSuccess<T> value)  fetchInvoicesSuccess,required TResult Function( FetchInvoicesError<T> value)  fetchInvoicesError,required TResult Function( CreateInvoiceSuccess<T> value)  createInvoiceSuccess,required TResult Function( CreateInvoiceError<T> value)  createInvoiceError,required TResult Function( FetchPatientsSuccess<T> value)  fetchPatientsSuccess,required TResult Function( FetchPatientsError<T> value)  fetchPatientsError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case FetchInvoicesSuccess():
return fetchInvoicesSuccess(_that);case FetchInvoicesError():
return fetchInvoicesError(_that);case CreateInvoiceSuccess():
return createInvoiceSuccess(_that);case CreateInvoiceError():
return createInvoiceError(_that);case FetchPatientsSuccess():
return fetchPatientsSuccess(_that);case FetchPatientsError():
return fetchPatientsError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( Loading<T> value)?  loading,TResult? Function( FetchInvoicesSuccess<T> value)?  fetchInvoicesSuccess,TResult? Function( FetchInvoicesError<T> value)?  fetchInvoicesError,TResult? Function( CreateInvoiceSuccess<T> value)?  createInvoiceSuccess,TResult? Function( CreateInvoiceError<T> value)?  createInvoiceError,TResult? Function( FetchPatientsSuccess<T> value)?  fetchPatientsSuccess,TResult? Function( FetchPatientsError<T> value)?  fetchPatientsError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case FetchInvoicesSuccess() when fetchInvoicesSuccess != null:
return fetchInvoicesSuccess(_that);case FetchInvoicesError() when fetchInvoicesError != null:
return fetchInvoicesError(_that);case CreateInvoiceSuccess() when createInvoiceSuccess != null:
return createInvoiceSuccess(_that);case CreateInvoiceError() when createInvoiceError != null:
return createInvoiceError(_that);case FetchPatientsSuccess() when fetchPatientsSuccess != null:
return fetchPatientsSuccess(_that);case FetchPatientsError() when fetchPatientsError != null:
return fetchPatientsError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T data)?  fetchInvoicesSuccess,TResult Function( String error)?  fetchInvoicesError,TResult Function( T data)?  createInvoiceSuccess,TResult Function( String error)?  createInvoiceError,TResult Function( T data)?  fetchPatientsSuccess,TResult Function( String error)?  fetchPatientsError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case FetchInvoicesSuccess() when fetchInvoicesSuccess != null:
return fetchInvoicesSuccess(_that.data);case FetchInvoicesError() when fetchInvoicesError != null:
return fetchInvoicesError(_that.error);case CreateInvoiceSuccess() when createInvoiceSuccess != null:
return createInvoiceSuccess(_that.data);case CreateInvoiceError() when createInvoiceError != null:
return createInvoiceError(_that.error);case FetchPatientsSuccess() when fetchPatientsSuccess != null:
return fetchPatientsSuccess(_that.data);case FetchPatientsError() when fetchPatientsError != null:
return fetchPatientsError(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T data)  fetchInvoicesSuccess,required TResult Function( String error)  fetchInvoicesError,required TResult Function( T data)  createInvoiceSuccess,required TResult Function( String error)  createInvoiceError,required TResult Function( T data)  fetchPatientsSuccess,required TResult Function( String error)  fetchPatientsError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case FetchInvoicesSuccess():
return fetchInvoicesSuccess(_that.data);case FetchInvoicesError():
return fetchInvoicesError(_that.error);case CreateInvoiceSuccess():
return createInvoiceSuccess(_that.data);case CreateInvoiceError():
return createInvoiceError(_that.error);case FetchPatientsSuccess():
return fetchPatientsSuccess(_that.data);case FetchPatientsError():
return fetchPatientsError(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T data)?  fetchInvoicesSuccess,TResult? Function( String error)?  fetchInvoicesError,TResult? Function( T data)?  createInvoiceSuccess,TResult? Function( String error)?  createInvoiceError,TResult? Function( T data)?  fetchPatientsSuccess,TResult? Function( String error)?  fetchPatientsError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case FetchInvoicesSuccess() when fetchInvoicesSuccess != null:
return fetchInvoicesSuccess(_that.data);case FetchInvoicesError() when fetchInvoicesError != null:
return fetchInvoicesError(_that.error);case CreateInvoiceSuccess() when createInvoiceSuccess != null:
return createInvoiceSuccess(_that.data);case CreateInvoiceError() when createInvoiceError != null:
return createInvoiceError(_that.error);case FetchPatientsSuccess() when fetchPatientsSuccess != null:
return fetchPatientsSuccess(_that.data);case FetchPatientsError() when fetchPatientsError != null:
return fetchPatientsError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements InvoiceState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InvoiceState<$T>.initial()';
}


}




/// @nodoc


class Loading<T> implements InvoiceState<T> {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InvoiceState<$T>.loading()';
}


}




/// @nodoc


class FetchInvoicesSuccess<T> implements InvoiceState<T> {
  const FetchInvoicesSuccess(this.data);
  

 final  T data;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchInvoicesSuccessCopyWith<T, FetchInvoicesSuccess<T>> get copyWith => _$FetchInvoicesSuccessCopyWithImpl<T, FetchInvoicesSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInvoicesSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'InvoiceState<$T>.fetchInvoicesSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $FetchInvoicesSuccessCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $FetchInvoicesSuccessCopyWith(FetchInvoicesSuccess<T> value, $Res Function(FetchInvoicesSuccess<T>) _then) = _$FetchInvoicesSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$FetchInvoicesSuccessCopyWithImpl<T,$Res>
    implements $FetchInvoicesSuccessCopyWith<T, $Res> {
  _$FetchInvoicesSuccessCopyWithImpl(this._self, this._then);

  final FetchInvoicesSuccess<T> _self;
  final $Res Function(FetchInvoicesSuccess<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(FetchInvoicesSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class FetchInvoicesError<T> implements InvoiceState<T> {
  const FetchInvoicesError({required this.error});
  

 final  String error;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchInvoicesErrorCopyWith<T, FetchInvoicesError<T>> get copyWith => _$FetchInvoicesErrorCopyWithImpl<T, FetchInvoicesError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInvoicesError<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'InvoiceState<$T>.fetchInvoicesError(error: $error)';
}


}

/// @nodoc
abstract mixin class $FetchInvoicesErrorCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $FetchInvoicesErrorCopyWith(FetchInvoicesError<T> value, $Res Function(FetchInvoicesError<T>) _then) = _$FetchInvoicesErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FetchInvoicesErrorCopyWithImpl<T,$Res>
    implements $FetchInvoicesErrorCopyWith<T, $Res> {
  _$FetchInvoicesErrorCopyWithImpl(this._self, this._then);

  final FetchInvoicesError<T> _self;
  final $Res Function(FetchInvoicesError<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(FetchInvoicesError<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateInvoiceSuccess<T> implements InvoiceState<T> {
  const CreateInvoiceSuccess(this.data);
  

 final  T data;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateInvoiceSuccessCopyWith<T, CreateInvoiceSuccess<T>> get copyWith => _$CreateInvoiceSuccessCopyWithImpl<T, CreateInvoiceSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateInvoiceSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'InvoiceState<$T>.createInvoiceSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $CreateInvoiceSuccessCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $CreateInvoiceSuccessCopyWith(CreateInvoiceSuccess<T> value, $Res Function(CreateInvoiceSuccess<T>) _then) = _$CreateInvoiceSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$CreateInvoiceSuccessCopyWithImpl<T,$Res>
    implements $CreateInvoiceSuccessCopyWith<T, $Res> {
  _$CreateInvoiceSuccessCopyWithImpl(this._self, this._then);

  final CreateInvoiceSuccess<T> _self;
  final $Res Function(CreateInvoiceSuccess<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(CreateInvoiceSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class CreateInvoiceError<T> implements InvoiceState<T> {
  const CreateInvoiceError({required this.error});
  

 final  String error;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateInvoiceErrorCopyWith<T, CreateInvoiceError<T>> get copyWith => _$CreateInvoiceErrorCopyWithImpl<T, CreateInvoiceError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateInvoiceError<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'InvoiceState<$T>.createInvoiceError(error: $error)';
}


}

/// @nodoc
abstract mixin class $CreateInvoiceErrorCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $CreateInvoiceErrorCopyWith(CreateInvoiceError<T> value, $Res Function(CreateInvoiceError<T>) _then) = _$CreateInvoiceErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$CreateInvoiceErrorCopyWithImpl<T,$Res>
    implements $CreateInvoiceErrorCopyWith<T, $Res> {
  _$CreateInvoiceErrorCopyWithImpl(this._self, this._then);

  final CreateInvoiceError<T> _self;
  final $Res Function(CreateInvoiceError<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CreateInvoiceError<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FetchPatientsSuccess<T> implements InvoiceState<T> {
  const FetchPatientsSuccess(this.data);
  

 final  T data;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchPatientsSuccessCopyWith<T, FetchPatientsSuccess<T>> get copyWith => _$FetchPatientsSuccessCopyWithImpl<T, FetchPatientsSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchPatientsSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'InvoiceState<$T>.fetchPatientsSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $FetchPatientsSuccessCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $FetchPatientsSuccessCopyWith(FetchPatientsSuccess<T> value, $Res Function(FetchPatientsSuccess<T>) _then) = _$FetchPatientsSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$FetchPatientsSuccessCopyWithImpl<T,$Res>
    implements $FetchPatientsSuccessCopyWith<T, $Res> {
  _$FetchPatientsSuccessCopyWithImpl(this._self, this._then);

  final FetchPatientsSuccess<T> _self;
  final $Res Function(FetchPatientsSuccess<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(FetchPatientsSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class FetchPatientsError<T> implements InvoiceState<T> {
  const FetchPatientsError({required this.error});
  

 final  String error;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchPatientsErrorCopyWith<T, FetchPatientsError<T>> get copyWith => _$FetchPatientsErrorCopyWithImpl<T, FetchPatientsError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchPatientsError<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'InvoiceState<$T>.fetchPatientsError(error: $error)';
}


}

/// @nodoc
abstract mixin class $FetchPatientsErrorCopyWith<T,$Res> implements $InvoiceStateCopyWith<T, $Res> {
  factory $FetchPatientsErrorCopyWith(FetchPatientsError<T> value, $Res Function(FetchPatientsError<T>) _then) = _$FetchPatientsErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FetchPatientsErrorCopyWithImpl<T,$Res>
    implements $FetchPatientsErrorCopyWith<T, $Res> {
  _$FetchPatientsErrorCopyWithImpl(this._self, this._then);

  final FetchPatientsError<T> _self;
  final $Res Function(FetchPatientsError<T>) _then;

/// Create a copy of InvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(FetchPatientsError<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
