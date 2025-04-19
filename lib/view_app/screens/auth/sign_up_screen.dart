import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _agreedToTerms = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorBlack,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fill your information below or register\nwith your social account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorTextGrey,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 40),
              _buildInputField(
                label: 'Name',
                controller: _nameController,
                hintText: 'John Doe',
                prefixIcon: Icon(Icons.person_outline, color: colorBlack),
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Email',
                controller: _emailController,
                hintText: 'example@gmail.com',
                prefixIcon: Icon(Icons.email_outlined, color: colorBlack),
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Password',
                controller: _passwordController,
                isPassword: true,
                hintText: '***************',
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
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _agreedToTerms
                      ? () {
                          // Handle sign up
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrinciple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    disabledBackgroundColor: colorPrinciple.withOpacity(0.5),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Or sign in with
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
                      // Handle Google sign up
                    },
                    image: 'assets/images/google_logo.png',
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    onTap: () {
                      // Handle Apple sign up
                    },
                    image: 'assets/images/apple_logo.png',
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    onTap: () {
                      // Handle Facebook sign up
                    },
                    icon: Icon(Icons.facebook, color: colorFacebookBlue, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: colorTextGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
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
          ),
        ),
      ),
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