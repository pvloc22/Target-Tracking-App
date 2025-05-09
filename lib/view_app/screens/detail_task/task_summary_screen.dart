import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TaskSummaryScreen extends StatefulWidget {
  const TaskSummaryScreen({super.key});

  @override
  State<TaskSummaryScreen> createState() => _TaskSummaryScreenState();
}

class _TaskSummaryScreenState extends State<TaskSummaryScreen> {
  // Sample data for the task summary
  final Map<String, dynamic> _taskData = {
    'title': 'TOEIC 700 - 900',
    'description': 'Complete vocabulary exercises for TOEIC test',
    'duration': '01:30:00',
    'startDate': DateTime(2023, 6, 15),
    'completionDate': DateTime(2023, 8, 10),
    'goal': 'TOEIC 700-800',
    'progress': 100,
  };

  // Sample data for time tracking
  final List<Map<String, dynamic>> _sessionData = [
    {
      'date': DateTime(2023, 7, 1),
      'duration': Duration(minutes: 45),
      'focus_rate': 85,
    },
    {
      'date': DateTime(2023, 7, 5),
      'duration': Duration(minutes: 50),
      'focus_rate': 90,
    },
    {
      'date': DateTime(2023, 7, 12),
      'duration': Duration(minutes: 60),
      'focus_rate': 75,
    },
    {
      'date': DateTime(2023, 7, 18),
      'duration': Duration(minutes: 40),
      'focus_rate': 95,
    },
    {
      'date': DateTime(2023, 7, 26),
      'duration': Duration(minutes: 55),
      'focus_rate': 88,
    },
    {
      'date': DateTime(2023, 8, 3),
      'duration': Duration(minutes: 40),
      'focus_rate': 92,
    },
    {
      'date': DateTime(2023, 8, 10),
      'duration': Duration(minutes: 20),
      'focus_rate': 80,
    },
  ];

  // Weekly chart data
  final List<Map<String, dynamic>> _weeklyData = [
    {'day': 'T2', 'minutes': 45},
    {'day': 'T3', 'minutes': 30},
    {'day': 'T4', 'minutes': 60},
    {'day': 'T5', 'minutes': 0},
    {'day': 'T6', 'minutes': 55},
    {'day': 'T7', 'minutes': 40},
    {'day': 'CN', 'minutes': 20},
  ];

  // Focus distribution data
  final Map<String, double> _focusDistribution = {
    'High Focus': 65,
    'Medium Focus': 25,
    'Low Focus': 10,
  };

  @override
  Widget build(BuildContext context) {
    // Calculate total time spent
    final int totalMinutes = _sessionData.fold(
        0, (sum, session) => sum + session['duration'].inMinutes as int);
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;

    // Calculate average focus rate
    final double avgFocusRate = _sessionData.fold(
            0.0, (sum, session) => sum + session['focus_rate'] as double) /
        _sessionData.length;

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorPrinciple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Task Summary',
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskCard(),
            const SizedBox(height: 24),
            
            // Time summary cards
            Row(
              children: [
                _buildSummaryCard(
                  title: 'Total Time',
                  value: '$hours h $minutes m',
                  icon: Icons.timer_outlined,
                  color: colorPrinciple,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  title: 'Avg. Focus Rate',
                  value: '${avgFocusRate.toStringAsFixed(0)}%',
                  icon: Icons.trending_up_outlined,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Weekly time chart
            _buildSectionTitle('Time Spent Per Day'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildWeeklyBarChart(),
            ),
            const SizedBox(height: 24),
            
            // Focus distribution chart
            _buildSectionTitle('Focus Distribution'),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildPieChart(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildFocusLegend(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Session history
            _buildSectionTitle('Session History'),
            ..._sessionData.map((session) => _buildSessionItem(session)).toList(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildTaskCard() {
    final startDate = DateFormat('dd/MM/yyyy').format(_taskData['startDate']);
    final completionDate = DateFormat('dd/MM/yyyy').format(_taskData['completionDate']);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorTaskGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: colorTaskGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _taskData['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _taskData['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: colorGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTaskInfoItem(
                icon: Icons.calendar_today_outlined,
                label: 'Started',
                value: startDate,
              ),
              _buildTaskInfoItem(
                icon: Icons.flag_outlined,
                label: 'Completed',
                value: completionDate,
              ),
              _buildTaskInfoItem(
                icon: Icons.timer_outlined,
                label: 'Duration',
                value: _taskData['duration'],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorTaskBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _taskData['goal'],
              style: const TextStyle(
                color: colorWhite,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: _taskData['progress'] / 100,
                  backgroundColor: colorLightGrey,
                  valueColor: const AlwaysStoppedAnimation<Color>(colorTaskGreen),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_taskData['progress']}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorTaskGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18, color: colorGrey),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: colorGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                color: colorBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorBlack,
        ),
      ),
    );
  }

  Widget _buildWeeklyBarChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _weeklyData.map((data) {
        // Calculate height percentage (max height is 150)
        double heightPercentage = (data['minutes'] as int) / 60;
        double height = 150 * heightPercentage;
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: colorPrinciple,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data['day'],
              style: const TextStyle(
                color: colorGrey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${data['minutes']}',
              style: const TextStyle(
                color: colorBlack,
                fontSize: 10,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: _getFocusSections(),
      ),
    );
  }

  List<PieChartSectionData> _getFocusSections() {
    final List<Color> colors = [
      colorTaskGreen,
      colorTaskBlue,
      colorDarkRed,
    ];

    return _focusDistribution.entries.toList().asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final color = colors[index % colors.length];

      return PieChartSectionData(
        color: color,
        value: data.value,
        title: '${data.value.toInt()}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildFocusLegend() {
    final List<Color> colors = [
      colorTaskGreen,
      colorTaskBlue,
      colorDarkRed,
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _focusDistribution.entries.toList().asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        final color = colors[index % colors.length];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.key,
                  style: const TextStyle(
                    fontSize: 12,
                    color: colorGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${data.value.toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorBlack,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSessionItem(Map<String, dynamic> session) {
    final date = session['date'] as DateTime;
    final duration = session['duration'] as Duration;
    final focusRate = session['focus_rate'] as int;
    
    // Choose color based on focus rate
    Color bgColor;
    Color iconColor;
    
    if (focusRate >= 85) {
      bgColor = const Color(0x334CB050); // Light green background
      iconColor = const Color(0xFF4CB050); // Green icon
    } else if (focusRate >= 70) {
      bgColor = const Color(0x332196F3); // Light blue background
      iconColor = const Color(0xFF2196F3); // Blue icon
    } else {
      bgColor = const Color(0x33DC3E73); // Light pink background
      iconColor = const Color(0xFFDC3E73); // Pink icon
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.timer_outlined,
              color: iconColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM dd, yyyy').format(date),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Session ${_sessionData.indexOf(session) + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: colorGrey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${duration.inMinutes} min',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Focus rate: $focusRate%',
                style: const TextStyle(
                  fontSize: 12,
                  color: colorGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
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
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrinciple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Back to Tasks',
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
}
