import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
@immutable  
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserCredential credential;
  LoginSuccess({required this.credential});
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}

class VisiblePassword extends LoginState {
  final bool isVisible;
  VisiblePassword({required this.isVisible});
}

class LoginGoogleSuccess extends LoginState {
  final UserCredential credential;
  LoginGoogleSuccess({required this.credential});
}