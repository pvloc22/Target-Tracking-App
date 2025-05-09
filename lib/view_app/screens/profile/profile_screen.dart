import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:app/view_app/screens/profile/edit_profile_screen.dart';

// New screen imports
import 'package:app/view_app/screens/profile/change_password_screen.dart';
import 'package:app/view_app/screens/profile/notification_settings_screen.dart';
import 'package:app/view_app/screens/profile/privacy_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'David Join',
    'email': 'david.join@example.com',
    'joinDate': 'January 15, 2023',
    'profileImage': 'DJ',
    'bio': 'Passionate about personal development and productivity. Working on becoming a better version of myself every day.',
    'location': 'San Francisco, CA',
    'goalsCreated': 22,
    'goalsCompleted': 10,
    'tasksCompleted': 156,
    'streak': 7,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorBlack),
          onPressed: () => _handleBackNavigation(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: colorBlack),
            onPressed: () => _navigateToEditProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            _buildBio(),
            _buildStats(),
            _buildAchievements(),
            _buildActivityFeed(),
            _buildActions(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile image and name
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: colorPrinciple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _userData['profileImage'],
                    style: const TextStyle(
                      color: colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userData['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorBlack,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _userData['email'],
                      style: TextStyle(
                        fontSize: 14,
                        color: colorBlack.withOpacity(0.6),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: colorGrey.withOpacity(0.8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _userData['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: colorGrey.withOpacity(0.8),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Join date
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: colorGrey.withOpacity(0.8),
                ),
                const SizedBox(width: 4),
                Text(
                  'Joined ${_userData['joinDate']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorGrey.withOpacity(0.8),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _userData['bio'],
            style: TextStyle(
              fontSize: 14,
              color: colorBlack.withOpacity(0.7),
              fontFamily: 'Inter',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colorShadow.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  title: 'Goals',
                  value: _userData['goalsCreated'].toString(),
                  icon: Icons.flag_outlined,
                  color: const Color(0xFF1CA4B4),
                ),
                _buildStatItem(
                  title: 'Completed',
                  value: _userData['goalsCompleted'].toString(),
                  icon: Icons.check_circle_outline,
                  color: const Color(0xFF4CAF50),
                ),
                _buildStatItem(
                  title: 'Tasks Done',
                  value: _userData['tasksCompleted'].toString(),
                  icon: Icons.task_alt_outlined,
                  color: const Color(0xFFFCAC2F),
                ),
                _buildStatItem(
                  title: 'Streak',
                  value: '${_userData['streak']} days',
                  icon: Icons.local_fire_department_outlined,
                  color: const Color(0xFFF44336),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: colorBlack.withOpacity(0.6),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Achievements',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildAchievementItem(
                  title: 'Early Bird',
                  description: 'Complete 5 tasks before 9 AM',
                  icon: Icons.wb_sunny_outlined,
                  color: const Color(0xFFFFC107),
                  isUnlocked: true,
                ),
                const SizedBox(width: 16),
                _buildAchievementItem(
                  title: 'Goal Setter',
                  description: 'Create 10 goals',
                  icon: Icons.flag_outlined,
                  color: const Color(0xFF2196F3),
                  isUnlocked: true,
                ),
                const SizedBox(width: 16),
                _buildAchievementItem(
                  title: 'Consistent',
                  description: 'Use the app for 7 consecutive days',
                  icon: Icons.calendar_today_outlined,
                  color: const Color(0xFF4CAF50),
                  isUnlocked: true,
                ),
                const SizedBox(width: 16),
                _buildAchievementItem(
                  title: 'Overachiever',
                  description: 'Complete 100 tasks',
                  icon: Icons.star_outline,
                  color: const Color(0xFF9C27B0),
                  isUnlocked: true,
                ),
                const SizedBox(width: 16),
                _buildAchievementItem(
                  title: 'Master Planner',
                  description: 'Complete 5 goals',
                  icon: Icons.psychology_outlined,
                  color: const Color(0xFF795548),
                  isUnlocked: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isUnlocked,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isUnlocked ? colorWhite : colorGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : colorGrey.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isUnlocked ? color : colorGrey.withOpacity(0.3),
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isUnlocked ? colorBlack : colorGrey.withOpacity(0.5),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 9,
                color: isUnlocked ? colorGrey : colorGrey.withOpacity(0.5),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFeed() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colorShadow.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildActivityItem(
                  action: 'Completed a goal',
                  detail: 'Retire by 35',
                  time: '2 days ago',
                  icon: Icons.flag,
                  color: const Color(0xFF4CAF50),
                ),
                const Divider(),
                _buildActivityItem(
                  action: 'Added new goal',
                  detail: 'Learn Flutter Development',
                  time: '3 days ago',
                  icon: Icons.add_circle_outline,
                  color: const Color(0xFF2196F3),
                ),
                const Divider(),
                _buildActivityItem(
                  action: 'Completed 3 tasks',
                  detail: 'Daily English practice',
                  time: '1 week ago',
                  icon: Icons.check_circle_outline,
                  color: const Color(0xFFFCAC2F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String action,
    required String detail,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorBlack.withOpacity(0.6),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: colorGrey.withOpacity(0.7),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorBlack,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colorShadow.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildActionItem(
                  title: 'Edit Profile',
                  icon: Icons.edit_outlined,
                  onTap: () => _navigateToEditProfile(context),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  title: 'Change Password',
                  icon: Icons.lock_outline,
                  onTap: () => _navigateToChangePassword(context),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  title: 'Notification Settings',
                  icon: Icons.notifications_outlined,
                  onTap: () => _navigateToNotificationSettings(context),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  title: 'Privacy Settings',
                  icon: Icons.security_outlined,
                  onTap: () => _navigateToPrivacySettings(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorPrinciple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: colorPrinciple,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colorBlack,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: colorGrey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _navigateToEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(userData: _userData),
      ),
    );
    
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _userData.clear();
        _userData.addAll(result);
      });
    }
  }
  
  void _navigateToChangePassword(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen(),
      ),
    );
  }
  
  void _navigateToNotificationSettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationSettingsScreen(),
      ),
    );
  }
  
  void _navigateToPrivacySettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrivacySettingsScreen(),
      ),
    );
  }
} 