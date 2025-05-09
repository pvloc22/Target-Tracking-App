import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Notification settings state
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;
  bool _goalRemindersEnabled = true;
  bool _taskDueRemindersEnabled = true;
  bool _weeklyProgressSummary = true;
  bool _achievementNotifications = true;
  bool _goalCompletionReminders = true;
  bool _streakNotifications = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Notification Channels'),
              const SizedBox(height: 8),
              _buildChannelSettings(),
              
              const SizedBox(height: 24),
              _buildHeader('Goals & Tasks Notifications'),
              const SizedBox(height: 8),
              _buildTaskGoalSettings(),
              
              const SizedBox(height: 24),
              _buildHeader('Progress & Achievements'),
              const SizedBox(height: 8),
              _buildProgressSettings(),
              
              const SizedBox(height: 20),
              _buildSaveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: colorBlack,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildChannelSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: _pushNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _pushNotificationsEnabled = value;
              });
            },
            leadingIcon: Icons.notifications,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: _emailNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _emailNotificationsEnabled = value;
              });
            },
            leadingIcon: Icons.email_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskGoalSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Goal Reminders',
            subtitle: 'Reminders for your ongoing goals',
            value: _goalRemindersEnabled,
            onChanged: (value) {
              setState(() {
                _goalRemindersEnabled = value;
              });
            },
            leadingIcon: Icons.flag_outlined,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Task Due Reminders',
            subtitle: 'Reminders for upcoming task deadlines',
            value: _taskDueRemindersEnabled,
            onChanged: (value) {
              setState(() {
                _taskDueRemindersEnabled = value;
              });
            },
            leadingIcon: Icons.task_alt_outlined,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Goal Completion',
            subtitle: 'Get notified when a goal is close to completion',
            value: _goalCompletionReminders,
            onChanged: (value) {
              setState(() {
                _goalCompletionReminders = value;
              });
            },
            leadingIcon: Icons.emoji_events_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Weekly Progress Summary',
            subtitle: 'Receive a weekly summary of your progress',
            value: _weeklyProgressSummary,
            onChanged: (value) {
              setState(() {
                _weeklyProgressSummary = value;
              });
            },
            leadingIcon: Icons.trending_up,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Achievements',
            subtitle: 'Get notified when you earn achievements',
            value: _achievementNotifications,
            onChanged: (value) {
              setState(() {
                _achievementNotifications = value;
              });
            },
            leadingIcon: Icons.military_tech_outlined,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Streak Notifications',
            subtitle: 'Get reminders to maintain your streak',
            value: _streakNotifications,
            onChanged: (value) {
              setState(() {
                _streakNotifications = value;
              });
            },
            leadingIcon: Icons.local_fire_department_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData leadingIcon,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorBlack,
          fontFamily: 'Inter',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: colorBlack.withOpacity(0.6),
          fontFamily: 'Inter',
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: colorPrinciple,
      secondary: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorPrinciple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          leadingIcon,
          color: colorPrinciple,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Save notification settings logic would go here
          // For now, just show a success message and navigate back
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification settings saved'),
              backgroundColor: Color(0xFF4CAF50),
            ),
          );
          
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrinciple,
          foregroundColor: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Save Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
} 