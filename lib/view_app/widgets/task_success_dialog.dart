import 'package:flutter/material.dart';

class TaskSuccessDialog extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final Function(String) onDescriptionSaved;

  const TaskSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onSubmit,
    required this.onCancel,
    required this.onDescriptionSaved,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onSubmit,
    required VoidCallback onCancel,
    required Function(String) onDescriptionSaved,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TaskSuccessDialog(
          title: title,
          message: message,
          onSubmit: onSubmit,
          onCancel: onCancel,
          onDescriptionSaved: onDescriptionSaved,
        );
      },
    );
  }

  @override
  State<TaskSuccessDialog> createState() => _TaskSuccessDialogState();
}

class _TaskSuccessDialogState extends State<TaskSuccessDialog> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
            // Success icon with green background
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
              widget.title,
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
              widget.message,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Color(0x99000000),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Text input area
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Ghi chú công việc bạn đã thực hiện...',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: InputBorder.none,
                ),
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            
            // Button row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                TextButton(
                  onPressed: widget.onCancel,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Huỷ',
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
                  onPressed: () {
                    widget.onDescriptionSaved(_descriptionController.text);
                    widget.onSubmit();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Lưu',
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