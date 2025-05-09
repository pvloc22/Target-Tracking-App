import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:intl/intl.dart';

class InformationTab extends StatefulWidget {
  const InformationTab({super.key});

  @override
  State<InformationTab> createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  final TextEditingController _titleController = TextEditingController(text: 'TOEIC 700 - 900');
  final TextEditingController _descriptionController = TextEditingController(text: 'Achieve TOEIC 700-900 score by practicing regularly');
  final TextEditingController _hoursController = TextEditingController(text: '80');
  
  DateTime _selectedDate = DateTime(2024, 12, 31);
  String _selectedReminder = 'Every week';
  Color _selectedColor = colorTaskBlue;
  IconData _selectedIcon = Icons.school_outlined;
  
  bool _isEditing = false;
  
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditing = !_isEditing;
                    if (!_isEditing) {
                      // Save logic would go here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Goal information updated')),
                      );
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: _isEditing ? colorTaskGreen.withOpacity(0.2) : colorPrinciple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isEditing ? Icons.save : Icons.edit,
                        color: _isEditing ? colorTaskGreen : colorPrinciple,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isEditing ? 'Save' : 'Edit',
                        style: TextStyle(
                          color: _isEditing ? colorTaskGreen : colorPrinciple,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  _buildSectionTitle('GOAL TITLE *'),
                  _isEditing
                      ? _buildTextField(_titleController, 'Enter goal title')
                      : _buildReadOnlyField(_titleController.text),
                  const SizedBox(height: 16),

                  _buildSectionTitle('GOAL DESCRIPTION'),
                  _isEditing
                      ? _buildTextField(_descriptionController, 'Enter goal description', maxLines: 3)
                      : _buildReadOnlyField(_descriptionController.text, maxLines: 3),
                  const SizedBox(height: 16),

                  _buildSectionTitle('ICON *'),
                  _isEditing
                      ? _buildIconSelector()
                      : _buildReadOnlyIconSelector(),
                  const SizedBox(height: 16),

                  _buildSectionTitle('COLOR'),
                  _isEditing
                      ? _buildColorSelector()
                      : _buildReadOnlyColorSelector(),
                  const SizedBox(height: 16),

                  _buildSectionTitle('REMINDER'),
                  _isEditing
                      ? _buildReminderSelector()
                      : _buildReadOnlyField(_selectedReminder),
                  const SizedBox(height: 16),

                  _buildSectionTitle('EXPECTED MATURITY DATE'),
                  _isEditing
                      ? _buildDateSelector()
                      : _buildReadOnlyField(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  const SizedBox(height: 16),

                  _buildSectionTitle('TARGET HOURS'),
                  _isEditing
                      ? _buildHoursSelector()
                      : _buildReadOnlyField('${_hoursController.text} hours'),
                  const SizedBox(height: 16),

                  if (!_isEditing) _buildProgressSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: colorTextGrey,
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

  Widget _buildReadOnlyIconSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
        color: colorLightGrey.withOpacity(0.1),
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
            _iconOptions.firstWhere((element) => element['icon'] == _selectedIcon)['label'],
            style: TextStyle(
              color: colorBlack,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSelector() {
    return GestureDetector(
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
    );
  }

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Select Icon',
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
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyColorSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
        color: colorLightGrey.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _selectedColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Container(
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
    );
  }

  Widget _buildReminderSelector() {
    return GestureDetector(
      onTap: _showReminderOptions,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: colorBorderGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.notifications_none, size: 20, color: colorBlack),
            const SizedBox(width: 12),
            Text(
              _selectedReminder,
              style: TextStyle(
                color: colorBlack,
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
    );
  }

  void _showReminderOptions() {
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
            ..._reminderOptions.map((reminder) => ListTile(
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

  Widget _buildDateSelector() {
    return GestureDetector(
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
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Widget _buildHoursSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, size: 20, color: colorBlack),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Target hours',
                contentPadding: EdgeInsets.zero,
                suffixText: 'hours',
                suffixStyle: TextStyle(
                  color: colorGrey,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    // Sample progress data
    final double progress = 0.45; // 45%
    
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
            '36 of 80 hours completed',
            style: TextStyle(
              color: colorGrey,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('Hours This Week', '12'),
              _buildStatItem('Total Sessions', '28'),
              _buildStatItem('Days Streak', '5'),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colorGrey,
          ),
        ),
      ],
    );
  }
}
