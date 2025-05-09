import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onSubmit,
    required this.onCancel,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onSubmit,
    required VoidCallback onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          title: title,
          message: message,
          onSubmit: onSubmit,
          onCancel: onCancel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFA5F4AA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF02B936),
                size: 24,
              ),
            ),
            const SizedBox(height: 10),
            
            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            
            // Message
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Color(0x99000000),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            
            // Divider
            Container(
              height: 1,
              color: const Color(0x1A000000),
            ),
            const SizedBox(height: 10),
            
            // Button row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3C3793),
                    ),
                  ),
                ),
                
                // Submit button
                TextButton(
                  onPressed: onSubmit,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3C3793),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 