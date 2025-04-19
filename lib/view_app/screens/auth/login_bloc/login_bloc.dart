import 'dart:math';

import 'package:app/view_app/screens/auth/login_bloc/login_event.dart';
import 'package:app/view_app/screens/auth/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/core/firebase/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();

  LoginBloc() : super(LoginInitial()){
    on<OnPressedLoginButton>(_onPressedLoginButton);
    on<OnPressedSignUpButton>(_onPressedSignUpButton);
    on<OnPressedForgotPasswordButton>(_onPressedForgotPasswordButton);
    on<OnPressedEyeButton>(_onPressedEyeButton);
    on<OnPressedGoogleLoginButton>(_onPressedGoogleLoginButton);
  }

  void _onPressedLoginButton(OnPressedLoginButton event, Emitter<LoginState> emit) async {
    emit(LoginLoading()); 
    try {
      final credential = await _authService.signInWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccess(credential: credential));
    } catch (e) {
      print('Login Error: ${e.toString()}');
      emit(LoginFailure(error: e.toString()));
    }
  }

  void _onPressedSignUpButton(OnPressedSignUpButton event, Emitter<LoginState> emit) {
    emit(LoginLoading());
  }

  void _onPressedForgotPasswordButton(OnPressedForgotPasswordButton event, Emitter<LoginState> emit) {
    emit(LoginLoading());
    }

  void _onPressedEyeButton(OnPressedEyeButton event, Emitter<LoginState> emit) {
    final isVisible = event.isVisible;
    if (isVisible) {
      emit(VisiblePassword(isVisible: false));
    } else {
      emit(VisiblePassword(isVisible: true));
    }
  }

  void _onPressedGoogleLoginButton(OnPressedGoogleLoginButton event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final credential = await _authService.signInWithGoogle();
      if (credential != null) {
        print('Google Login Success');
        emit(LoginGoogleSuccess(credential: credential));
      } else {
        print('Google Login Failed');
        emit(LoginFailure(error: 'Google Login Failed'));
      }
    } catch (e) {
      print('Google Login Error: ${e.toString()}');
      emit(LoginFailure(error: e.toString()));
    }
  }

}
