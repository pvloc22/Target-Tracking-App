import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:app/view_app/screens/detail_task/watch_task_screen.dart';
import 'package:intl/intl.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  final TextEditingController _titleController = TextEditingController(text: 'TOEIC 700 - 900');
  final TextEditingController _descriptionController = TextEditingController(text: 'By saving at least 100 minimum; a month before retirement');
  final TextEditingController _practiceHoursController = TextEditingController(text: '01:00');
  final TextEditingController _searchController = TextEditingController();
  
  DateTime _selectedDate = DateTime(2025, 3, 11);
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 0);
  String _selectedReminder = '15 min';
  String _selectedRepeat = 'Weekly';
  Color _selectedColor = colorTaskBlue;
  String _selectedGoal = 'TOEIC 700-800';
  
  bool _isEditing = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _practiceHoursController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorPrinciple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Detail Task',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: colorWhite,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.05),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: colorWhite),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                if (!_isEditing) {
                  // Implement save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task updated successfully')),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('TASK TITLE'),
            _isEditing 
              ? _buildTextField(_titleController, 'Enter task title')
              : _buildReadOnlyField(_titleController.text),
            const SizedBox(height: 14),
            
            _buildSectionTitle('TASK DESCRIPTION'),
            _isEditing 
              ? _buildTextField(_descriptionController, 'Enter task description', maxLines: 3)
              : _buildReadOnlyField(_descriptionController.text, maxLines: 3),
            const SizedBox(height: 14),

            _buildSectionTitle('LINK TO GOAL'),
            _isEditing 
              ? _buildGoalSelector()
              : _buildReadOnlyField(_selectedGoal),
            const SizedBox(height: 14),

            _buildSectionTitle('COLOR'),
            _buildColorSelector(),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('DATE'),
                      _isEditing 
                        ? _buildDateSelector()
                        : _buildReadOnlyField(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('TIME'),
                      _isEditing 
                        ? _buildTimeSelector()
                        : _buildReadOnlyField(_selectedTime.format(context)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _buildSectionTitle('REMINDER'),
            _isEditing 
              ? _buildReminderSelector()
              : _buildReadOnlyField(_selectedReminder),
            const SizedBox(height: 14),

            _buildSectionTitle('REPEAT'),
            _isEditing 
              ? _buildRepeatSelector()
              : _buildReadOnlyField(_selectedRepeat),
            const SizedBox(height: 14),

            _buildSectionTitle('PRACTICE HOURS'),
            _isEditing 
              ? _buildPracticeHoursSelector()
              : _buildReadOnlyField('${_practiceHoursController.text} hours'),
            const SizedBox(height: 24),

            _buildCompletionStatus(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: colorShadow,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String value, {int maxLines = 1}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
        color: colorLightGrey.withOpacity(0.1),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: colorBlack,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: colorGrey,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    final List<Color> colors = [
      colorDarkRed,
      colorBlueMint,
      colorTaskBlue,
      colorDarkYellow,
      colorStartButton,
      colorTaskGreen,
      colorDarkPink,
    ];

    return SizedBox(
      height: 40,
      child: _isEditing 
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedColor = colors[index]),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: colors[index],
                      shape: BoxShape.circle,
                      border: _selectedColor == colors[index]
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                ),
              );
            },
          )
        : Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 20, color: colorBlack),
            const SizedBox(width: 8),
            Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: _showTimePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 20, color: colorBlack),
            const SizedBox(width: 8),
            Text(
              _selectedTime.format(context),
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderSelector() {
    return GestureDetector(
      onTap: _showReminderOptions,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedReminder,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: colorBlack),
          ],
        ),
      ),
    );
  }

  void _showReminderOptions() {
    final List<String> reminders = ['5 min', '10 min', '15 min', '30 min', '1 hour'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Select Reminder',
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: colorBlack),
                  ),
                ],
              ),
            ),
            const Divider(),
            ...reminders.map((reminder) => ListTile(
              onTap: () {
                setState(() => _selectedReminder = reminder);
                Navigator.pop(context);
              },
              title: Text(
                reminder,
                style: TextStyle(
                  color: _selectedReminder == reminder ? colorPrinciple : colorBlack,
                  fontSize: 14,
                  fontWeight: _selectedReminder == reminder ? FontWeight.w600 : FontWeight.normal,
                  fontFamily: 'Inter',
                ),
              ),
              trailing: _selectedReminder == reminder 
                ? Icon(Icons.check, color: colorPrinciple)
                : null,
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatSelector() {
    return Column(
      children: [
        _buildRepeatOption('None', _selectedRepeat == 'None'),
        _buildRepeatOption('Daily', _selectedRepeat == 'Daily'),
        _buildRepeatOption('Weekly', _selectedRepeat == 'Weekly'),
        _buildRepeatOption('Monthly', _selectedRepeat == 'Monthly'),
      ],
    );
  }

  Widget _buildRepeatOption(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedRepeat = text),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? colorPrinciple : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? colorPrinciple
                      : colorPrinciple.withOpacity(0.6),
                  width: 2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeHoursSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, size: 20, color: colorBlack),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: _practiceHoursController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter hours (e.g. 01:00)',
                contentPadding: EdgeInsets.zero,
                suffixText: 'hours',
                suffixStyle: TextStyle(
                  color: colorGrey,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              onChanged: _validateAndFormatTime,
            ),
          ),
        ],
      ),
    );
  }

  void _validateAndFormatTime(String value) {
    // Remove any non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.isEmpty) {
      _practiceHoursController.text = '';
      return;
    }

    // Pad with zeros if needed
    digitsOnly = digitsOnly.padLeft(4, '0');
    
    // Take only the last 4 digits
    if (digitsOnly.length > 4) {
      digitsOnly = digitsOnly.substring(digitsOnly.length - 4);
    }

    // Split into hours and minutes
    int hours = int.parse(digitsOnly.substring(0, 2));
    int minutes = int.parse(digitsOnly.substring(2));

    // Validate hours and minutes
    if (hours > 23) hours = 23;
    if (minutes > 59) minutes = 59;

    // Format the time
    String formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    // Update text field
    _practiceHoursController.value = TextEditingValue(
      text: formattedTime,
      selection: TextSelection.collapsed(offset: formattedTime.length),
    );
  }

  Widget _buildGoalSelector() {
    return GestureDetector(
      onTap: _showGoalOptions,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedGoal,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: colorBlack),
          ],
        ),
      ),
    );
  }

  void _showGoalOptions() {
    // This is a sample list of goals. In a real app, you would fetch this from your backend
    final List<String> goals = [
      'TOEIC 700-800',
      'Learn Flutter',
      'Get AWS Certification',
      'Complete 30-Day Workout Challenge',
      'Read 12 Books This Year'
    ];

    List<String> filteredGoals = List.from(goals);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Select Goal',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: colorBlack),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search goals...',
                      prefixIcon: Icon(Icons.search, color: colorGrey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredGoals = goals
                            .where((goal) => goal.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGoals.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      this.setState(() => _selectedGoal = filteredGoals[index]);
                      _searchController.clear();
                      Navigator.pop(context);
                    },
                    title: Text(
                      filteredGoals[index],
                      style: TextStyle(
                        color: _selectedGoal == filteredGoals[index] ? colorPrinciple : colorBlack,
                        fontSize: 14,
                        fontWeight: _selectedGoal == filteredGoals[index] ? FontWeight.w600 : FontWeight.normal,
                        fontFamily: 'Inter',
                      ),
                    ),
                    trailing: _selectedGoal == filteredGoals[index]
                      ? Icon(Icons.check, color: colorPrinciple)
                      : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Widget _buildCompletionStatus() {
    // Sample completion status: 3 of 5 days completed
    final double progress = 0.6; // 60%
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorLightGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  color: colorPrinciple,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: colorLightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(colorPrinciple),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 10),
          Text(
            '3 of 5 days completed',
            style: TextStyle(
              color: colorGrey,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchTaskScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrinciple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Start Task',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorDarkRed),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                _showDeleteConfirmation();
              },
              icon: Icon(Icons.delete_outline, color: colorDarkRed),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: colorGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: colorDarkRed),
            ),
          ),
        ],
      ),
    );
  }
}
