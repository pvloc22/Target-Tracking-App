import 'package:app/view_app/screens/auth/forgot_password_screen.dart';
import 'package:app/view_app/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginScreeForm();
}

class _LoginScreeForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _mailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final ValueNotifier<String> _mailError = ValueNotifier('');
  final ValueNotifier<String> _passwordError = ValueNotifier('');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _mailError.dispose();
    _passwordError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              print('Login Success');
            }
            else if (state is LoginFailure) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Login Failed'),
                      content: Text(state.error),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
              );
            } 
            else if (state is LoginGoogleSuccess) {
              Navigator.pop(context);
              print('Google Login Success');
            }
            else if (state is LoginLoading) {
              showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_headerLoginPage(), _formInputLoginPage(), _loginMethods()],
          ),
        ),
      ),
    );
  }

  bool validateInput() {
    if (_emailController.text.isEmpty) {
      _mailError.value = 'Email is required';
      _mailFocusNode.requestFocus();
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(_emailController.text)) {
      _mailError.value = 'Invalid email address';
      _mailFocusNode.requestFocus();
      return false;
    } else if (_passwordController.text.isEmpty) {
      _mailError.value = '';
      _passwordError.value = 'Password is required';
      _passwordFocusNode.requestFocus();
      return false;
    }

    _mailError.value = '';
    _passwordError.value = '';

    return true;
  }

  Widget _headerLoginPage() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          'Sign in',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: colorBlack, fontFamily: 'Inter'),
        ),
        const SizedBox(height: 8),
        Text(
          "Hi Welcome back, you've been missed",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorTextGrey, fontFamily: 'Inter'),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _formInputLoginPage() {
    return Form(
      key: _formKey,
      child: Column(children: [_buildUsernameInput(), _buildPasswordInput(), _buildForgotPassword()]),
    );
  }

  Widget _buildUsernameInput() {
    return ValueListenableBuilder(
      valueListenable: _mailError,
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: TextFormField(
            controller: _emailController,
            focusNode: _mailFocusNode,
            decoration: InputDecoration(
              hintText: 'example@gmail.com',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBorderGrey),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorPrinciple, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorDarkRed, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorDarkRed, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              prefixIcon: Icon(Icons.person_outline, color: colorBlack),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              errorText: value.isEmpty ? null : value,
            ),
            onFieldSubmitted: (value) {
              _mailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return ValueListenableBuilder(
      valueListenable: _passwordError,
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is VisiblePassword) {
                return _PasswordInputField(state.isVisible, value);
              }
              return _PasswordInputField(false, value);
            },
          ),
        );
      },
    );
  }

  Widget _PasswordInputField(bool isVisible, String value) {
    return TextFormField(
      controller: _passwordController,
      obscureText: !isVisible,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: colorTextGrey, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        prefixIcon: Icon(Icons.lock_outline, color: colorBlack),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorPrinciple, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorDarkRed, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorDarkRed, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: colorBlack),
          onPressed: () {
            context.read<LoginBloc>().add(OnPressedEyeButton(isVisible: isVisible));
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        errorText: value.isEmpty ? null : value,
      ),
      onFieldSubmitted: (value) {
        _passwordFocusNode.unfocus();
      },
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: colorBrown,
              // decorationThickness: 1.0,
              color: colorBrown,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginMethods() {
    return Column(
      children: [
        /// Login button
        Container(
          margin: EdgeInsets.only(bottom: 32),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (validateInput()) {
                context.read<LoginBloc>().add(
                  OnPressedLoginButton(email: _emailController.text, password: _passwordController.text),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorPrinciple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: Text(
              'Login in',
              style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
          ),
        ),

        /// Or sign in with
        Row(
          children: [
            Expanded(child: Divider(color: colorDividerGrey, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or sign in with',
                style: TextStyle(color: colorTextGrey, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
              ),
            ),
            Expanded(child: Divider(color: colorDividerGrey, thickness: 1)),
          ],
        ),
        const SizedBox(height: 32),
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              onTap: () {
                context.read<LoginBloc>().add(OnPressedGoogleLoginButton());
              },
              image: 'assets/images/google_logo.png',
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              onTap: () {
                // Handle Apple login
              },
              image: 'assets/images/apple_logo.png',
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              onTap: () {
                // Handle Facebook login
              },
              icon: Icon(Icons.facebook, color: colorFacebookBlue, size: 24),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Sign Up Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(color: colorTextGrey, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: colorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({required VoidCallback onTap, String? image, Icon? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorDividerGrey),
          color: colorWhite,
        ),
        child: Center(child: image != null ? Image.asset(image, width: 24, height: 24) : icon),
      ),
    );
  }
}
