import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/create_task/create_task_screen.dart';
import 'package:app/view_app/screens/goals/create_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigator_bar_bloc/bottom_navigator_bar_bloc.dart';
import 'bottom_navigator_bar_bloc/bottom_navigator_bar_event.dart';
import 'bottom_navigator_bar_bloc/bottom_navigator_bar_state.dart';
class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigatorBarBloc, BottomNavigatorBarState>(
      builder: (context, state) {
        if(state is BottomNavigatorBarCurrentIndexChanged) {
          _currentIndex = state.currentIndex;
        } 
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [BoxShadow(color: colorShadow, blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: HOME_PAGE_INDEX,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            _buildNavItem(
              index: CALENDAR_PAGE_INDEX,
              icon: Icons.calendar_today_outlined,
              activeIcon: Icons.calendar_today,
              label: 'Calendar',
              ),
            _buildAddButton(),
            _buildNavItem(
                index: SEARCH_PAGE_INDEX,
                icon: Icons.search,
                activeIcon: Icons.search,
                label: 'Search',
            ),
            _buildNavItem(
              index: ANALYST_PAGE_INDEX,
              icon: Icons.analytics_outlined,
              activeIcon: Icons.analytics,
              label: 'Analytics',
            ),
          ],
        ),
      );
      },
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        context.read<BottomNavigatorBarBloc>().add(BottomNavChanged(currentIndex: index));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? colorPrinciple.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isSelected ? activeIcon : icon, color: isSelected ? colorPrinciple : colorTextGrey, size: 25),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? colorPrinciple : colorTextGrey,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: -5,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: colorPrinciple,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorPrinciple, colorPrinciple.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: colorPrinciple.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showAddBottomSheet,
          customBorder: const CircleBorder(),
          child: Icon(Icons.add, color: colorWhite, size: 32),
        ),
      ),
    );
  }

  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
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
                    Text('Create', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: colorBlack)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: colorBlack)),
                  ],
                ),
                _buildAddOption(
                  icon: Icons.task_alt_outlined,
                  color: colorTaskBlue,
                  title: 'Add Task',
                  subtitle: 'Create a new task with details',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskScreen()));
                  },
                ),
                _buildAddOption(
                  icon: Icons.flag_outlined,
                  color: colorTaskRed,
                  title: 'Add Goal',
                  subtitle: 'Set a new goal to achieve',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGoalScreen()));
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAddOption({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(border: Border.all(color: colorBorderGrey), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorBlack, fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: colorTextGrey, fontFamily: 'Inter')),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: colorTextGrey, size: 16),
          ],
        ),
      ),
    );
  }
}
