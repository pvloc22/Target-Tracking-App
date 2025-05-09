import 'package:app/core/style/colors.dart';
import 'package:app/view_app/widgets/appbar_new_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hoursController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedReminder = 'Every month';
  Color _selectedColor = colorTaskBlue;
  IconData _selectedIcon = Icons.flag_outlined;

  final List<Color> _colors = [
    colorBlueMint,
    colorBlue,
    colorDarkYellow,
    colorDarkPink,
    colorGreen,
    colorPrinciple,
  ];

  final List<Map<String, dynamic>> _iconOptions = [
    {'icon': Icons.flag_outlined, 'label': 'Flag'},
    {'icon': Icons.star_outline, 'label': 'Star'},
    {'icon': Icons.favorite_outline, 'label': 'Heart'},
    {'icon': Icons.lightbulb_outline, 'label': 'Idea'},
    {'icon': Icons.school_outlined, 'label': 'Education'},
    {'icon': Icons.work_outline, 'label': 'Work'},
    {'icon': Icons.fitness_center_outlined, 'label': 'Fitness'},
    {'icon': Icons.attach_money_outlined, 'label': 'Money'},
    {'icon': Icons.book_outlined, 'label': 'Book'},
    {'icon': Icons.sports_esports_outlined, 'label': 'Games'},
    {'icon': Icons.brush_outlined, 'label': 'Art'},
    {'icon': Icons.music_note_outlined, 'label': 'Music'},
  ];

  final List<String> _reminderOptions = [
    'Every day',
    'Every week',
    'Every month',
    'Every 3 months',
    'Every 6 months',
    'Every year',
    'Custom',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarNewItem(title: 'Create Goal'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: colorWhite,
              borderRadius:BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                label: 'GOAL TITLE *',
                controller: _titleController,
                hintText: 'Enter goal title',
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'GOAL DESCRIPTION',
                controller: _descriptionController,
                hintText: 'Enter goal description',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildIconSelector(),
              const SizedBox(height: 16),
              _buildColorSelector(),
              const SizedBox(height: 16),
              _buildReminderSelector(),
              const SizedBox(height: 16),
              _buildDateSelector(),
              const SizedBox(height: 16),
              _buildHoursSelector(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [
            BoxShadow(
              color: colorShadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle create goal
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorPrinciple,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Create Goal',
            style: TextStyle(
              color: colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorTextGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: 12
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Icon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: colorBlack),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: _iconOptions.length,
              itemBuilder: (context, index) {
                final option = _iconOptions[index];
                final isSelected = option['icon'] == _selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIcon = option['icon']);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? colorPrinciple.withOpacity(0.1) : colorWhite,
                      border: Border.all(
                        color: isSelected ? colorPrinciple : colorBorderGrey,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          option['icon'],
                          color: isSelected ? colorPrinciple : colorBlack,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option['label'],
                          style: TextStyle(
                            color: isSelected ? colorPrinciple : colorTextGrey,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Reminder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: colorBlack),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: _reminderOptions.map((option) {
                    final isSelected = option == _selectedReminder;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedReminder = option);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? colorPrinciple.withOpacity(0.1) : colorWhite,
                          border: Border.all(
                            color: isSelected ? colorPrinciple : colorBorderGrey,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? colorPrinciple : colorBlack,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                            if (isSelected) ...[
                              const Spacer(),
                              Icon(Icons.check, color: colorPrinciple),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ICON *',
          style: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showIconPicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorBorderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _selectedColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_selectedIcon, color: _selectedColor),
                ),
                const SizedBox(width: 12),
                Text(
                  'Change',
                  style: TextStyle(
                    color: colorPrinciple.withOpacity(0.8),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: colorBlack),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLOR',
          style: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: _colors.map((color) {
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: _selectedColor == color ? Icon(Icons.check, color: colorWhite) : null,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REMINDER',
          style: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showReminderPicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorBorderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_outlined, size: 20, color: colorBlack),
                const SizedBox(width: 12),
                Text(
                  _selectedReminder,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down, color: colorBlack),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colorPrinciple,
              onPrimary: colorWhite,
              onSurface: colorBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colorPrinciple,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPECTED MATURITY DATE',
          style: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showDatePicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorBorderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 20, color: colorBlack),
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd/MM/yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down, color: colorBlack),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHoursSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPECTED HOURS',
          style: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: colorBorderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.timer_outlined, size: 20, color: colorBlack),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _hoursController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter hours',
                    hintStyle: TextStyle(
                      color: colorTextGrey,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    suffixText: 'hours',
                    suffixStyle: TextStyle(
                      color: colorBlack,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (value) {
                    // Optional: Add validation here
                    if (value.isNotEmpty) {
                      final hours = int.tryParse(value);
                      if (hours == null || hours < 0) {
                        _hoursController.text = '';
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
