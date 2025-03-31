import 'package:app/view_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/core/style/colors.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  bool _isResendEnabled = true;
  int _resendTimer = 60;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Widget _buildCodeInput(int index) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: _focusNodes[index].hasFocus ? colorPrinciple : Color(0xFFE9E9E9),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorBlack,
          fontFamily: 'Inter',
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _onCodeChanged(value, index),
      ),
    );
  }

  void _startResendTimer() {
    setState(() {
      _isResendEnabled = false;
      _resendTimer = 60;
    });
    // Add timer implementation here
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
                'Verify Code',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorBlack,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter the code we just sent to email\n${widget.email}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorTextGrey,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 40),
              // Code Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.5),
                    child: _buildCodeInput(index),
                  );
                }),
              ),
              const SizedBox(height: 32),
              // Resend Code
              Column(
                children: [
                  Text(
                    "Didn't receive OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorTextGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: _isResendEnabled ? _startResendTimer : null,
                    child: Text(
                      _isResendEnabled
                          ? 'Resend code'
                          : 'Resend code in $_resendTimer seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // decoration: un,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _isResendEnabled ? colorPrinciple : colorTextGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle verification
                    String code = _controllers.map((c) => c.text).join();
                    if (code.length == 4) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (Route<dynamic> route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrinciple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Verify',
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
      ),
    );
  }
} 