import 'package:flutter/material.dart';

class TaskCompletionDialog extends StatefulWidget {
  final String title;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final Function(String) onDescriptionSaved;

  const TaskCompletionDialog({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.onCancel,
    required this.onDescriptionSaved,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required VoidCallback onSubmit,
    required VoidCallback onCancel,
    required Function(String) onDescriptionSaved,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TaskCompletionDialog(
          title: title,
          onSubmit: onSubmit,
          onCancel: onCancel,
          onDescriptionSaved: onDescriptionSaved,
        );
      },
    );
  }

  @override
  State<TaskCompletionDialog> createState() => _TaskCompletionDialogState();
}

class _TaskCompletionDialogState extends State<TaskCompletionDialog> {
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
            // Task icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_outlined,
                color: Color(0xFF3C3793),
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
            const SizedBox(height: 16),
            
            // Description textarea
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Ghi chú công việc bạn đã thực hiện...',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: InputBorder.none,
                ),
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            
            // Divider
            Container(
              height: 1,
              color: const Color(0x1A000000),
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