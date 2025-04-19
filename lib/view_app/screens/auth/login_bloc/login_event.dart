import 'package:flutter/cupertino.dart';
@immutable
abstract class LoginEvent {}

class OnPressedLoginButton extends LoginEvent {
  final String email;
  final String password;
  OnPressedLoginButton({required this.email, required this.password});
}

class OnPressedSignUpButton extends LoginEvent {
  final String email;
  final String password;
  OnPressedSignUpButton({required this.email, required this.password});
}

class OnPressedForgotPasswordButton extends LoginEvent {
  final String email;
  OnPressedForgotPasswordButton({required this.email});
}

class OnPressedEyeButton extends LoginEvent {
  final bool isVisible;
  OnPressedEyeButton({required this.isVisible});
}

class OnPressedGoogleLoginButton extends LoginEvent {
  OnPressedGoogleLoginButton();
}