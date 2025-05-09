import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/style/colors.dart';
import '../../widgets/appbar_new_item.dart';

class CreateTaskScreen extends StatefulWidget {
  final String? goalId;
  const CreateTaskScreen({super.key, this.goalId});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _practiceHoursController = TextEditingController(text: '02:30');
  final TextEditingController _searchController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedReminder = '15 min';
  String _selectedRepeat = 'None';
  Color _selectedColor = colorTaskBlue;
  String? _selectedGoal;

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
      appBar: AppbarNewItem(title: 'Create A Task'),
      body: Container(
        color: colorWhite,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('TASK TITLE *'),
              _buildTextField(_titleController, 'Enter task title'),

              _buildSectionTitle('TASK DESCRIPTION'),
              _buildTextField(_descriptionController, 'Enter task description', maxLines: 3),
              if (widget.goalId == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('LINK TO GOAL'),
                    _buildGoalSelector(),
                  ],
                ),

              _buildSectionTitle('COLOR'),
              _buildColorSelector(),

              Container(
                margin: EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('DATE *'),
                          _buildDateSelector(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('TIME *'),
                          _buildTimeSelector(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              _buildSectionTitle('REMINDER'),
              _buildReminderSelector(),

              // _buildSectionTitle('REPEAT'),
              // _buildRepeatSelector(),

              _buildSectionTitle('PRACTICE HOURS'),
              _buildPracticeHoursSelector(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: colorShadow,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(bottom: 14),
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

    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: 14),
      child: ListView.builder(
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
                ),
                child: Center(
                  child: _selectedColor == colors[index] ? Icon(Icons.check, color: colorWhite) : null,
                ),
              ),
            ),
          );
        },
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
        margin: EdgeInsets.only(bottom: 14),
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
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          _buildRepeatOption('None', true),
          _buildRepeatOption('Daily', false),
          _buildRepeatOption('Weekly', false),
          _buildRepeatOption('Monthly', false),
        ],
      ),
    );
  }

  Widget _buildRepeatOption(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
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
                  color: _selectedRepeat == text ? colorPrinciple : Colors.transparent,
                  border: Border.all(
                    color: _selectedRepeat == text
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
      ),
    );
  }

  Widget _buildPracticeHoursSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.only(bottom: 14),
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
                hintText: 'Enter hours (e.g. 02:30)',
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

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _createTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrinciple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          'Create Task',
          style: TextStyle(
            color: colorWhite,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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

  void _createTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }
    // TODO: Implement task creation logic
    Navigator.pop(context);
  }

  Widget _buildGoalSelector() {
    return GestureDetector(
      onTap: _showGoalOptions,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedGoal ?? 'Select a goal',
              style: TextStyle(
                color: _selectedGoal != null ? colorBlack : colorGrey,
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
                child: filteredGoals.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 48, color: colorGrey),
                            const SizedBox(height: 16),
                            Text(
                              'No goals found',
                              style: TextStyle(
                                color: colorGrey,
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
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
}
