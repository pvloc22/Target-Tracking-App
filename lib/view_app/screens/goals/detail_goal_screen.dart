import 'package:app/core/style/colors.dart';
import 'package:app/view_app/screens/goals/widgets/information_tab.dart';
import 'package:app/view_app/widgets/TaskItem.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/utils/sliver_stat_cards_delegate.dart';
import '../create_task/create_task_screen.dart';


class DetailGoalScreen extends StatefulWidget {
  const DetailGoalScreen({super.key});

  @override
  State<DetailGoalScreen> createState() => _DetailGoalScreenState();
}

class _DetailGoalScreenState extends State<DetailGoalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  int _selectedChartDay = 4; // Friday is selected by default (index 4)
  int _selectedColorIndex = 0;

  // Time range picker state
  String _selectedTimeRange = 'Day';
  DateTime _startDate = DateTime(2024, 3, 1);
  DateTime _endDate = DateTime(2024, 3, 31);

  // Sample tasks for the selected day
  final List<Map<String, dynamic>> _fridayTasks = [
    {
      'title': 'TOEIC Practice Test',
      'description': 'Complete reading section',
      'duration': '60 Minutes',
      'date': '12/04/2025',
      'time': '09:00 AM',
    },
    {
      'title': 'Vocabulary Review',
      'description': 'Study business vocabulary',
      'duration': '45 Minutes',
      'date': '12/04/2025',
      'time': '11:00 AM',
    },
    {
      'title': 'Listening Exercise',
      'description': 'Complete 10 listening questions',
      'duration': '30 Minutes',
      'date': '12/04/2025',
      'time': '02:00 PM',
    },
  ];

  // Colors for color selection in Information tab
  final List<Color> _colorOptions = [
    colorTransparent,
    colorYellow,
    colorOrange,
    colorGreen,
    colorPurple,
    colorCyan,
    colorLightBlue,
    colorPink,
    colorBrightRed,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colorLightGrey.withOpacity(0.1),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          // _buildTitle(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTabIndex) {
      case 0: // Overview
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildWaterLevelIndicator()),
            SliverToBoxAdapter(child: _buildStatCards()),
            SliverPersistentHeader(
              pinned: true, // giữ lại khi scroll
              floating: true,
              delegate: SliverStatCardsDelegate(
                minHeight: 50,
                maxHeight: 70,
                child: Container(
                  color: backgroundColor,
                  padding: EdgeInsets.only(left: 16, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today's Task",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    ),
                  ),
                ),
              ),
            ),
            _buildTasksList(),
          ],
        );
      case 1: // Analysis
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildTimeRangePicker()),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverStatCardsDelegate(minHeight: 350, maxHeight: 350, child: _buildWeeklyChart()),
            ),
            _buildSelectedDayTasks(),
          ],
        );
      case 2: // Information
        return _buildInformationTab();
      default:
        return Container();
    }
  }

  Widget _buildHeader() {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: topPadding + 16, left: 16, bottom: 16, right: 16),
      color: colorPrinciple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: colorWhite, size: 24),
          ),
          const Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Detail Goal',
                  style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateTaskScreen(goalId: '123')));
            },
            icon: const Icon(Icons.add_task, color: colorWhite, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [_buildTabItem('Overview', 0), _buildTabItem('Analysis', 1), _buildTabItem('Information', 2)],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _currentTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
            _tabController.animateTo(index);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? colorPrinciple : colorWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? colorWhite : colorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'TOEIC 700-800',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: colorBlack,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('Tasks Completed', '24/30', 'Tasks')),
          const SizedBox(width: 10),
          Expanded(child: _buildStatCard('Done Hours', '24,3/120', 'Hours')),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String type) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter', color: colorBlack),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
              children: [
                TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold)),
                type == 'Tasks'
                    ? TextSpan(
                      text: " (Tasks)",
                      style: TextStyle(color: colorBlack, fontStyle: FontStyle.italic, fontSize: 10),
                    )
                    : TextSpan(
                      text: " (Hours)",
                      style: TextStyle(color: colorBlack, fontStyle: FontStyle.italic, fontSize: 10),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 8, (context, index) {
        return TaskItem(
          title: 'TOEIC 700 - 900',
          description: 'By saving at least 100 minimum; a month before retirement',
          duration: '60 Minutes',
          date: DateTime(2025, 3, 11),
          time: TimeOfDay(hour: 10, minute: 0),
          isCompleted: true,
          onComplete: () {},
          onDelete: () {},
        );
      }),
    );
  }

  Widget _buildWaterLevelIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            // padding: EdgeInsets.all(70),
            decoration: BoxDecoration(shape: BoxShape.circle, color: colorPrinciple.withOpacity(0.12)),
            child: LiquidCircularProgressIndicator(
              value: 0.50,
              // 10%
              direction: Axis.vertical,
              valueColor: AlwaysStoppedAnimation<Color>(colorBlue),
              backgroundColor: Colors.transparent,
              center: const Text(
                "50%",
                style: TextStyle(color: colorBlack, fontSize: 60, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
              ),
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  // Analysis tab widgets
  Widget _buildWeeklyChart() {
    // Data for each day of the week (height value)
    final List<double> barHeights = [40, 55, 70, 85, 120, 60, 45, 67, 32, 42];
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'fd', 'fda', 'fdafd'];

    return Column(
      children: [
        Container(
          height: 300,
          margin: EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 4))],
          ),
          child: Stack(
            children: [
              BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 150,
                  minY: 0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.transparent,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem('', const TextStyle(color: Colors.transparent));
                      },
                    ),
                    touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
                      if (response != null && response.spot != null && event is FlTapUpEvent) {
                        setState(() {
                          _selectedChartDay = response.spot!.touchedBarGroupIndex;
                        });
                      }
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              days[value.toInt()],
                              style: TextStyle(
                                color: _selectedChartDay == value.toInt() ? colorBlack : colorBlack.withOpacity(0.2),
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups:
                      barHeights.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final double height = entry.value;

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: height,
                              color: index == _selectedChartDay ? colorPrinciple : Colors.grey.shade300,
                              width: 20,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
              if (_selectedChartDay == 4) // Only show for Friday (index 4)
                Positioned(
                  top: 35,
                  right: 90,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(color: colorShadow.withOpacity(0.4), blurRadius: 4, offset: const Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Tasks: 3', style: TextStyle(color: colorBlack, fontSize: 8, fontWeight: FontWeight.w300)),
                        Text('Time: 3h', style: TextStyle(color: colorBlack, fontSize: 8, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRangePicker() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 0, left: 16, right: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time Range',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colorBlack, fontFamily: 'Inter'),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildTimeOption('Day', _selectedTimeRange == 'Day'),
              SizedBox(width: 8),
              _buildTimeOption('Week', _selectedTimeRange == 'Week'),
              SizedBox(width: 8),
              _buildTimeOption('Month', _selectedTimeRange == 'Month'),
              SizedBox(width: 8),
              _buildTimeOption('Year', _selectedTimeRange == 'Year'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDatePicker('From: ${_formatDate(_startDate)}', true),
              Icon(Icons.arrow_forward, size: 16, color: colorGrey),
              _buildDatePicker('To: ${_formatDate(_endDate)}', false),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _buildTimeOption(String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTimeRange = label;
            // Simulated date range change based on selection
            if (label == 'Day') {
              _startDate = DateTime(2024, 3, 1);
              _endDate = DateTime(2024, 3, 1);
            } else if (label == 'Week') {
              _startDate = DateTime(2024, 3, 1);
              _endDate = DateTime(2024, 3, 7);
            } else if (label == 'Month') {
              _startDate = DateTime(2024, 3, 1);
              _endDate = DateTime(2024, 3, 31);
            } else if (label == 'Year') {
              _startDate = DateTime(2024, 1, 1);
              _endDate = DateTime(2024, 12, 31);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorPrinciple : colorLightGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? colorWhite : colorBlack,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, bool isStartDate) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(isStartDate);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: colorLightGrey)),
        child: Row(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: colorBlack, fontFamily: 'Inter')),
            SizedBox(width: 4),
            Icon(Icons.calendar_today, size: 14, color: colorGrey),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(bool isStartDate) async {
    final initialDate = isStartDate ? _startDate : _endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: colorPrinciple)),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // Ensure end date is not before start date
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          // Ensure start date is not after end date
          if (_startDate.isAfter(_endDate)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  Widget _buildSelectedDayTasks() {
    if (_selectedChartDay != 4) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: const Center(
          child: Text(
            'No tasks for selected day',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorGrey),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: _fridayTasks.length, (context, index) {
        final task = _fridayTasks[index];
        return TaskItem(
          title: task['title'],
          description: 'By saving at least 100 minimum; a month before retirement',
          duration: '60 Minutes',
          date: DateTime(2025, 3, 11),
          time: TimeOfDay(hour: 10, minute: 0),
          isCompleted: false,
          onComplete: () {},
          onDelete: () {},
        );
      }),
    );
  }

  // Information tab widgets
  Widget _buildInformationTab() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: InformationTab()),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(color: colorPrinciple.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, color: colorPrinciple, size: 18),
            const SizedBox(width: 2),
            Text(
              'Edit',
              style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: colorPrinciple),
            ),
          ],
        ),
      ),
    );
  }
}
