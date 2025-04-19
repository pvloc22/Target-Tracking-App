import 'package:app/view_app/screens/auth/login_bloc/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/view_app/screens/auth/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginBloc(), child: LoginForm());
  }
}
