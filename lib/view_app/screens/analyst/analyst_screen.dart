import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar.dart';
import 'package:app/data/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalystScreen extends StatefulWidget {
  const AnalystScreen({super.key});

  @override
  State<AnalystScreen> createState() => _AnalystScreenState();
}

class _AnalystScreenState extends State<AnalystScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample data for analytics
  final List<Map<String, dynamic>> _recentActivities = [
    {
      'description': 'Đọc sách tiếng Anh',
      'minutes': 45,
      'type': 'study',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'description': 'Luyện nghe IELTS',
      'minutes': 30,
      'type': 'focus',
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'description': 'Học từ vựng mới',
      'minutes': 25,
      'type': 'study',
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'description': 'Viết essay',
      'minutes': 60,
      'type': 'focus',
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];
  
  // Weekly time data
  final List<Map<String, dynamic>> _weeklyData = [
    {'day': 'T2', 'minutes': 120},
    {'day': 'T3', 'minutes': 90},
    {'day': 'T4', 'minutes': 150},
    {'day': 'T5', 'minutes': 80},
    {'day': 'T6', 'minutes': 200},
    {'day': 'T7', 'minutes': 60},
    {'day': 'CN', 'minutes': 30},
  ];
  
  // Category breakdown
  final Map<String, double> _categoryData = {
    'Học tập': 45,
    'Làm việc': 25,
    'Đọc sách': 15,
    'Thể thao': 10,
    'Khác': 5,
  };
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total tracked time
    int totalMinutes = _recentActivities.fold(0, (sum, activity) => sum + activity['minutes'] as int);
    int totalHours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;
    
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Phân tích',
          style: TextStyle(
            color: colorBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary cards row
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    _buildSummaryCard(
                      title: 'Thời gian',
                      value: '$totalHours giờ $remainingMinutes phút',
                      icon: Icons.timer_outlined,
                      color: colorPrinciple,
                    ),
                    const SizedBox(width: 16),
                    _buildSummaryCard(
                      title: 'Mục tiêu tuần',
                      value: '75%',
                      icon: Icons.flag_outlined,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              
              // Weekly chart
              _buildSectionTitle('Biểu đồ thời gian tuần này'),
              Container(
                padding: const EdgeInsets.all(16),
                child: _buildWeeklyBarChart(),
              ),
              
              // Activity breakdown
              _buildSectionTitle('Phân loại hoạt động'),
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildPieChart(),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildCategoryLegend(),
                    ),
                  ],
                ),
              ),
              
              // Recent activities
              _buildSectionTitle('Hoạt động gần đây'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recentActivities.length,
                itemBuilder: (context, index) {
                  final activity = _recentActivities[index];
                  return _buildActivityItem(activity);
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
        double heightPercentage = (data['minutes'] as int) / 200;
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
        sections: _getCategorySections(),
      ),
    );
  }
  
  List<PieChartSectionData> _getCategorySections() {
    final List<Color> colors = [
      colorPrinciple,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.purple,
    ];
    
    return _categoryData.entries.toList().asMap().entries.map((entry) {
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
  
  Widget _buildCategoryLegend() {
    final List<Color> colors = [
      colorPrinciple,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.purple,
    ];
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _categoryData.entries.toList().asMap().entries.map((entry) {
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
  
  Widget _buildActivityItem(Map<String, dynamic> activity) {
    // Define colors based on type
    Color bgColor;
    Color iconColor;
    
    switch (activity['type']) {
      case 'study':
        bgColor = const Color(0x332196F3); // Light blue background
        iconColor = const Color(0xFF2196F3); // Blue icon
        break;
      case 'break':
        bgColor = const Color(0x33DC3E73); // Light pink background
        iconColor = const Color(0xFFDC3E73); // Pink icon
        break;
      case 'focus':
        bgColor = const Color(0x334CB050); // Light green background
        iconColor = const Color(0xFF4CB050); // Green icon
        break;
      default:
        bgColor = const Color(0x332196F3);
        iconColor = const Color(0xFF2196F3);
    }
    
    // Format date
    final date = activity['date'] as DateTime;
    final formattedDate = '${date.day}/${date.month}';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  activity['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    color: colorGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${activity['minutes']} phút',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 