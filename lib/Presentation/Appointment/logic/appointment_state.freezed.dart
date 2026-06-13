// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppointmentState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppointmentState<$T>()';
}


}

/// @nodoc
class $AppointmentStateCopyWith<T,$Res>  {
$AppointmentStateCopyWith(AppointmentState<T> _, $Res Function(AppointmentState<T>) __);
}


/// Adds pattern-matching-related methods to [AppointmentState].
extension AppointmentStatePatterns<T> on AppointmentState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( Loading<T> value)?  loading,TResult Function( Success<T> value)?  success,TResult Function( _UpdateSuccess<T> value)?  updateSuccess,TResult Function( Error<T> value)?  error,TResult Function( _ListSuccess<T> value)?  listSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case _UpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case Error() when error != null:
return error(_that);case _ListSuccess() when listSuccess != null:
return listSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( Loading<T> value)  loading,required TResult Function( Success<T> value)  success,required TResult Function( _UpdateSuccess<T> value)  updateSuccess,required TResult Function( Error<T> value)  error,required TResult Function( _ListSuccess<T> value)  listSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case _UpdateSuccess():
return updateSuccess(_that);case Error():
return error(_that);case _ListSuccess():
return listSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( Loading<T> value)?  loading,TResult? Function( Success<T> value)?  success,TResult? Function( _UpdateSuccess<T> value)?  updateSuccess,TResult? Function( Error<T> value)?  error,TResult? Function( _ListSuccess<T> value)?  listSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case _UpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case Error() when error != null:
return error(_that);case _ListSuccess() when listSuccess != null:
return listSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T data)?  success,TResult Function( String message)?  updateSuccess,TResult Function( String error)?  error,TResult Function( List<AppointmentItem> appointments)?  listSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.data);case _UpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.message);case Error() when error != null:
return error(_that.error);case _ListSuccess() when listSuccess != null:
return listSuccess(_that.appointments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T data)  success,required TResult Function( String message)  updateSuccess,required TResult Function( String error)  error,required TResult Function( List<AppointmentItem> appointments)  listSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.data);case _UpdateSuccess():
return updateSuccess(_that.message);case Error():
return error(_that.error);case _ListSuccess():
return listSuccess(_that.appointments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T data)?  success,TResult? Function( String message)?  updateSuccess,TResult? Function( String error)?  error,TResult? Function( List<AppointmentItem> appointments)?  listSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.data);case _UpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.message);case Error() when error != null:
return error(_that.error);case _ListSuccess() when listSuccess != null:
return listSuccess(_that.appointments);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements AppointmentState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppointmentState<$T>.initial()';
}


}




/// @nodoc


class Loading<T> implements AppointmentState<T> {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppointmentState<$T>.loading()';
}


}




/// @nodoc


class Success<T> implements AppointmentState<T> {
  const Success(this.data);
  

 final  T data;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<T, Success<T>> get copyWith => _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'AppointmentState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<T,$Res> implements $AppointmentStateCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$SuccessCopyWithImpl<T,$Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<T> _self;
  final $Res Function(Success<T>) _then;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(Success<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class _UpdateSuccess<T> implements AppointmentState<T> {
  const _UpdateSuccess(this.message);
  

 final  String message;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateSuccessCopyWith<T, _UpdateSuccess<T>> get copyWith => __$UpdateSuccessCopyWithImpl<T, _UpdateSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateSuccess<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppointmentState<$T>.updateSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UpdateSuccessCopyWith<T,$Res> implements $AppointmentStateCopyWith<T, $Res> {
  factory _$UpdateSuccessCopyWith(_UpdateSuccess<T> value, $Res Function(_UpdateSuccess<T>) _then) = __$UpdateSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UpdateSuccessCopyWithImpl<T,$Res>
    implements _$UpdateSuccessCopyWith<T, $Res> {
  __$UpdateSuccessCopyWithImpl(this._self, this._then);

  final _UpdateSuccess<T> _self;
  final $Res Function(_UpdateSuccess<T>) _then;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UpdateSuccess<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Error<T> implements AppointmentState<T> {
  const Error({required this.error});
  

 final  String error;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<T, Error<T>> get copyWith => _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AppointmentState<$T>.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<T,$Res> implements $AppointmentStateCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ErrorCopyWithImpl<T,$Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error<T> _self;
  final $Res Function(Error<T>) _then;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Error<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ListSuccess<T> implements AppointmentState<T> {
  const _ListSuccess(final  List<AppointmentItem> appointments): _appointments = appointments;
  

 final  List<AppointmentItem> _appointments;
 List<AppointmentItem> get appointments {
  if (_appointments is EqualUnmodifiableListView) return _appointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appointments);
}


/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListSuccessCopyWith<T, _ListSuccess<T>> get copyWith => __$ListSuccessCopyWithImpl<T, _ListSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListSuccess<T>&&const DeepCollectionEquality().equals(other._appointments, _appointments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_appointments));

@override
String toString() {
  return 'AppointmentState<$T>.listSuccess(appointments: $appointments)';
}


}

/// @nodoc
abstract mixin class _$ListSuccessCopyWith<T,$Res> implements $AppointmentStateCopyWith<T, $Res> {
  factory _$ListSuccessCopyWith(_ListSuccess<T> value, $Res Function(_ListSuccess<T>) _then) = __$ListSuccessCopyWithImpl;
@useResult
$Res call({
 List<AppointmentItem> appointments
});




}
/// @nodoc
class __$ListSuccessCopyWithImpl<T,$Res>
    implements _$ListSuccessCopyWith<T, $Res> {
  __$ListSuccessCopyWithImpl(this._self, this._then);

  final _ListSuccess<T> _self;
  final $Res Function(_ListSuccess<T>) _then;

/// Create a copy of AppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? appointments = null,}) {
  return _then(_ListSuccess<T>(
null == appointments ? _self._appointments : appointments // ignore: cast_nullable_to_non_nullable
as List<AppointmentItem>,
  ));
}


}

// dart format on
