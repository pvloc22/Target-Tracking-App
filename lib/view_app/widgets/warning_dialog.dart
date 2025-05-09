import 'package:flutter/material.dart';

class WarningDialog extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final Function(String) onDescriptionSaved;

  const WarningDialog({
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
        return WarningDialog(
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
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning icon with yellow background
            Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0x33DCCA30), // 20% opacity yellow
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFAE63C),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 13),
            
            // Title
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 13),
            
            // Message
            Text(
              widget.message,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            
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
            const SizedBox(height: 13),
            
            // Button row - right aligned
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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