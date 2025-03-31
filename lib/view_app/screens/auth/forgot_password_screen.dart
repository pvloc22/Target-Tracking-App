import 'package:app/view_app/screens/auth/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePasswords() {
    bool isValid = true;
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
        isValid = false;
      } else if (_passwordController.text.length < 8) {
        _passwordError = 'Password must be at least 8 characters';
        isValid = false;
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Confirm password is required';
        isValid = false;
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        isValid = false;
      }
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE9E9E9)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back, color: colorBlack),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: colorBlack,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your new password must be different\nfrom previously used passwords',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorTextGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildPasswordField(
              label: 'Password',
              controller: _passwordController,
              isVisible: _isPasswordVisible,
              onVisibilityChanged: (value) {
                setState(() => _isPasswordVisible = value);
              },
              errorText: _passwordError,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              label: 'Confirm password',
              controller: _confirmPasswordController,
              isVisible: _isConfirmPasswordVisible,
              onVisibilityChanged: (value) {
                setState(() => _isConfirmPasswordVisible = value);
              },
              errorText: _confirmPasswordError,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_validatePasswords()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(email: 'example@gmail.com')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrinciple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Create New Password',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required Function(bool) onVisibilityChanged,
    String? errorText,
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
            border: Border.all(
              color: errorText != null ? colorRed : colorBorderGrey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
            decoration: InputDecoration(
              hintText: '*********************',
              hintStyle: TextStyle(
                color: colorTextGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: colorBlack,
                ),
                onPressed: () => onVisibilityChanged(!isVisible),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              errorText,
              style: TextStyle(
                color: colorRed,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ),
      ],
    );
  }

} 