// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( CheckAuthStatus value)?  checkAuthStatus,TResult Function( ContinueWithGoogle value)?  continueWithGoogle,TResult Function( SignIn value)?  signIn,TResult Function( SignUp value)?  signUp,TResult Function( SignOut value)?  signOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case ContinueWithGoogle() when continueWithGoogle != null:
return continueWithGoogle(_that);case SignIn() when signIn != null:
return signIn(_that);case SignUp() when signUp != null:
return signUp(_that);case SignOut() when signOut != null:
return signOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( CheckAuthStatus value)  checkAuthStatus,required TResult Function( ContinueWithGoogle value)  continueWithGoogle,required TResult Function( SignIn value)  signIn,required TResult Function( SignUp value)  signUp,required TResult Function( SignOut value)  signOut,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case CheckAuthStatus():
return checkAuthStatus(_that);case ContinueWithGoogle():
return continueWithGoogle(_that);case SignIn():
return signIn(_that);case SignUp():
return signUp(_that);case SignOut():
return signOut(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( CheckAuthStatus value)?  checkAuthStatus,TResult? Function( ContinueWithGoogle value)?  continueWithGoogle,TResult? Function( SignIn value)?  signIn,TResult? Function( SignUp value)?  signUp,TResult? Function( SignOut value)?  signOut,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case ContinueWithGoogle() when continueWithGoogle != null:
return continueWithGoogle(_that);case SignIn() when signIn != null:
return signIn(_that);case SignUp() when signUp != null:
return signUp(_that);case SignOut() when signOut != null:
return signOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  checkAuthStatus,TResult Function()?  continueWithGoogle,TResult Function( String email,  String password)?  signIn,TResult Function( String name,  String email,  String password)?  signUp,TResult Function()?  signOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case ContinueWithGoogle() when continueWithGoogle != null:
return continueWithGoogle();case SignIn() when signIn != null:
return signIn(_that.email,_that.password);case SignUp() when signUp != null:
return signUp(_that.name,_that.email,_that.password);case SignOut() when signOut != null:
return signOut();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  checkAuthStatus,required TResult Function()  continueWithGoogle,required TResult Function( String email,  String password)  signIn,required TResult Function( String name,  String email,  String password)  signUp,required TResult Function()  signOut,}) {final _that = this;
switch (_that) {
case Started():
return started();case CheckAuthStatus():
return checkAuthStatus();case ContinueWithGoogle():
return continueWithGoogle();case SignIn():
return signIn(_that.email,_that.password);case SignUp():
return signUp(_that.name,_that.email,_that.password);case SignOut():
return signOut();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  checkAuthStatus,TResult? Function()?  continueWithGoogle,TResult? Function( String email,  String password)?  signIn,TResult? Function( String name,  String email,  String password)?  signUp,TResult? Function()?  signOut,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case ContinueWithGoogle() when continueWithGoogle != null:
return continueWithGoogle();case SignIn() when signIn != null:
return signIn(_that.email,_that.password);case SignUp() when signUp != null:
return signUp(_that.name,_that.email,_that.password);case SignOut() when signOut != null:
return signOut();case _:
  return null;

}
}

}

/// @nodoc


class Started implements AuthEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class CheckAuthStatus implements AuthEvent {
  const CheckAuthStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckAuthStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class ContinueWithGoogle implements AuthEvent {
  const ContinueWithGoogle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContinueWithGoogle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.continueWithGoogle()';
}


}




/// @nodoc


class SignIn implements AuthEvent {
  const SignIn(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInCopyWith<SignIn> get copyWith => _$SignInCopyWithImpl<SignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignIn&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signIn(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignInCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignInCopyWith(SignIn value, $Res Function(SignIn) _then) = _$SignInCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$SignInCopyWithImpl<$Res>
    implements $SignInCopyWith<$Res> {
  _$SignInCopyWithImpl(this._self, this._then);

  final SignIn _self;
  final $Res Function(SignIn) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SignIn(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignUp implements AuthEvent {
  const SignUp(this.name, this.email, this.password);
  

 final  String name;
 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpCopyWith<SignUp> get copyWith => _$SignUpCopyWithImpl<SignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUp&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,password);

@override
String toString() {
  return 'AuthEvent.signUp(name: $name, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignUpCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignUpCopyWith(SignUp value, $Res Function(SignUp) _then) = _$SignUpCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password
});




}
/// @nodoc
class _$SignUpCopyWithImpl<$Res>
    implements $SignUpCopyWith<$Res> {
  _$SignUpCopyWithImpl(this._self, this._then);

  final SignUp _self;
  final $Res Function(SignUp) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,}) {
  return _then(SignUp(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignOut implements AuthEvent {
  const SignOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOut()';
}


}




// dart format on
