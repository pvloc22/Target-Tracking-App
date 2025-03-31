import 'package:app/view_app/screens/auth/forgot_password_screen.dart';
import 'package:app/view_app/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _headerLoginPage(),
            _formInputLoginPage(),
            _loginMethods(),
            // Login Button


          ],
        ),
      ),
    );
  }

  Widget _headerLoginPage(){
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          'Sign in',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Hi Welcome back, you've been missed",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorTextGrey,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _formInputLoginPage(){
    return Column(
      children: [
        /// input username/email
        Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'example@gmail.com',
              hintStyle: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              prefixIcon: Icon(Icons.person_outline, color: colorBlack),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        /// input password
        Container(
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: '***************',
              hintStyle: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              prefixIcon: Icon(Icons.lock_outline, color: colorBlack),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: colorBlack,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),

        ///Forgot password
        Container(
          margin: EdgeInsets.only(bottom: 24),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
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
        ),
      ],
    );
  }

  Widget _loginMethods(){
    return Column(
      children: [
        /// Login button
        Container(
          margin: EdgeInsets.only(bottom: 32),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorPrinciple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Login in',
              style: TextStyle(
                color: colorWhite,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),

        /// Or sign in with
        Row(
          children: [
            Expanded(
              child: Divider(color: colorDividerGrey, thickness: 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or sign in with',
                style: TextStyle(
                  color: colorTextGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Expanded(
              child: Divider(color: colorDividerGrey, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              onTap: () {
                // Handle Google login
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
              style: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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
  Widget _buildSocialButton({
    required VoidCallback onTap,
    String? image,
    Icon? icon,
  }) {
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
        child: Center(
          child: image != null
              ? Image.asset(image, width: 24, height: 24)
              : icon,
        ),
      ),
    );
  }
} 