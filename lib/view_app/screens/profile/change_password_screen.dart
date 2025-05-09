import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  
  double _passwordStrength = 0.0;
  String _passwordStrengthText = 'Weak';
  Color _passwordStrengthColor = Colors.red;
  
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  void _checkPasswordStrength(String password) {
    // Password strength criteria
    final bool hasMinLength = password.length >= 8;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigits = password.contains(RegExp(r'[0-9]'));
    final bool hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    int strength = 0;
    if (hasMinLength) strength++;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigits) strength++;
    if (hasSpecialChars) strength++;
    
    setState(() {
      // Calculate percentage
      _passwordStrength = strength / 5;
      
      // Set text and color based on strength
      if (_passwordStrength <= 0.3) {
        _passwordStrengthText = 'Weak';
        _passwordStrengthColor = Colors.red;
      } else if (_passwordStrength <= 0.6) {
        _passwordStrengthText = 'Medium';
        _passwordStrengthColor = Colors.orange;
      } else if (_passwordStrength <= 0.8) {
        _passwordStrengthText = 'Strong';
        _passwordStrengthColor = Colors.blue;
      } else {
        _passwordStrengthText = 'Very Strong';
        _passwordStrengthColor = Colors.green;
      }
    });
  }
  
  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // Navigate back after showing success message
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Password icon and description
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: colorPrinciple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: colorPrinciple,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Create a strong password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorBlack,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your password should be at least 8 characters long and include a mix of uppercase letters, lowercase letters, numbers, and special characters.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorBlack.withOpacity(0.6),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Current password
                _buildPasswordField(
                  controller: _currentPasswordController,
                  label: 'Current Password',
                  hint: 'Enter your current password',
                  obscureText: _obscureCurrentPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                // New password
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: 'New Password',
                  hint: 'Enter your new password',
                  obscureText: _obscureNewPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (value == _currentPasswordController.text) {
                      return 'New password must be different from current password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _checkPasswordStrength(value);
                  },
                ),
                
                const SizedBox(height: 8),
                
                // Password strength indicator
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: _passwordStrength,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(_passwordStrengthColor),
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _passwordStrengthText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _passwordStrengthColor,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Confirm new password
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm New Password',
                  hint: 'Confirm your new password',
                  obscureText: _obscureConfirmPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _changePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrinciple,
                      foregroundColor: colorWhite,
                      disabledBackgroundColor: colorPrinciple.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(colorWhite),
                            ),
                          )
                        : const Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback toggleObscureText,
    required String? Function(String?) validator,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorBlack.withOpacity(0.8),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colorGrey.withOpacity(0.6),
              fontFamily: 'Inter',
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: colorPrinciple,
              size: 22,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: colorGrey,
                size: 22,
              ),
              onPressed: toggleObscureText,
            ),
            filled: true,
            fillColor: colorGrey.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorGrey.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: colorPrinciple,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
} 