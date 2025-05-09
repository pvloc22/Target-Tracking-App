import 'package:app/core/business/base_size_screen.dart';
import 'package:app/core/utils/sliver_stat_cards_delegate.dart';
import 'package:app/view_app/widgets/GoalItem.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:app/view_app/screens/auth/login_screen.dart';
import 'package:app/view_app/screens/settings/settings_screen.dart';
import 'package:app/view_app/screens/profile/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightHeader = BaseSizeScreen.responsiveHeightHeader(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverStatCardsDelegate(minHeight: heightHeader, maxHeight: heightHeader, child: _buildHeader()),
          ),
          SliverToBoxAdapter(child: _buildGoalsSummary()),
          SliverToBoxAdapter(child: _buildTodayTasks()),
          SliverToBoxAdapter(child: _buildGoals()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      color: colorPrinciple,
      padding: EdgeInsets.only(top: paddingTop + 16, bottom: 16, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(color: colorGrey, shape: BoxShape.circle),
                  child: const Center(
                    child: Text("DJ", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ),
              const Text(
                "David Join",
                style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Inter'),
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.menu, color: colorWhite), onPressed: () => _showMenu(context)),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: colorGrey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
                ),

                _buildMenuHeader(),
                const SizedBox(height: 20),

                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: "Profile",
                  subtitle: "Edit your personal information",
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to profile screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  },
                ),

                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: "Settings",
                  subtitle: "Manage app settings and preferences",
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                ),

                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  subtitle: "Configure your notification preferences",
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to notifications screen
                  },
                ),

                _buildMenuItem(
                  icon: Icons.analytics_outlined,
                  title: "Statistics",
                  subtitle: "View your goals and tasks analytics",
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to statistics screen
                  },
                ),

                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "Get assistance and contact support",
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to help & support screen
                  },
                ),

                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),

                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  subtitle: "Sign out from your account",
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutConfirmation(context);
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  Widget _buildMenuHeader() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: colorPrinciple, shape: BoxShape.circle),
          child: const Center(
            child: Text("DJ", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "David Join",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack, fontFamily: 'Inter'),
            ),
            const SizedBox(height: 4),
            Text(
              "david.join@example.com",
              style: TextStyle(fontSize: 14, color: colorBlack.withOpacity(0.6), fontFamily: 'Inter'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final Color textColor = isDestructive ? colorTaskRed : colorBlack;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDestructive ? colorTaskRed.withOpacity(0.1) : colorPrinciple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isDestructive ? colorTaskRed : colorPrinciple, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor, fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7), fontFamily: 'Inter'),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: textColor.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
          content: const Text(
            "Are you sure you want to logout from your account?",
            style: TextStyle(fontFamily: 'Inter'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel", style: TextStyle(color: colorBlack.withOpacity(0.7), fontFamily: 'Inter')),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context);
              },
              child: Text(
                "Logout",
                style: TextStyle(color: colorTaskRed, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // TODO: Implement actual logout functionality
    // This could include:
    // 1. Clearing user session data
    // 2. Clearing any cached data
    // 3. Signing out from authentication services
    // 4. Navigating to login screen

    // For now, we'll just navigate to the login screen as an example
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Widget _buildGoalsSummary() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is SuccessHomeScreen) {
          final int inProcessGoals = state.goals.length;
          final int completedGoals = state.goals.length;
          final int archivedGoals = state.goals.length;
          final int totalGoals = inProcessGoals + completedGoals + archivedGoals;
          
          return _summaryGoals(
            totalGoals: totalGoals,
            inProcessGoals: inProcessGoals,
            completedGoals: completedGoals,
            archivedGoals: archivedGoals,
          );
        }
        return _summaryGoals(
          totalGoals: 0,
          inProcessGoals: 0,
          completedGoals: 0,
          archivedGoals: 0,
        );
      },
    );
  }
  Widget _summaryGoals({required int totalGoals, required int inProcessGoals,required int completedGoals, required int archivedGoals}) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: colorPrinciple,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Text("$totalGoals Goals", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            const Text(
              "You're an ambitious person, aren't you?",
              style: TextStyle(fontSize: 14, color: colorBlack, fontFamily: 'Inter'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGoalStat("IN PROCESS", "$inProcessGoals", Colors.black87),
                _buildGoalStat("COMPLETED", "$completedGoals", Colors.black87),
                _buildGoalStat("ARCHIVED", "$archivedGoals", Colors.black87),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGoalStat(String label, String count, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: color, fontFamily: 'Inter')),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: colorBlack, fontFamily: 'Inter'),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicator: const BoxDecoration(),
        indicatorPadding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        tabs: [_buildTab("Goals", 0), _buildTab("Goals Completed", 1), _buildTab("Goals Archived", 2)],
      ),
    );
  }

  Widget _buildListGoal() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5, // Set a fixed height or calculate based on screen size
      child: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: New Goals
          SingleChildScrollView(child: _buildGoalsList(status: "new")),
          // Tab 2: Goals in progress/completed
          SingleChildScrollView(child: _buildGoalsList(status: "completed")),
          // Tab 3: Archived Goals
          SingleChildScrollView(child: _buildGoalsList(status: "archived")),
        ],
      ),
    );
  }

  Widget _buildGoalsList({required String status}) {
    // Different goals based on status
    List<Map<String, dynamic>> goalItems = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        goalItems.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: goalItems.length,
                itemBuilder: (context, index) {
                  return GoalItem(
                    title: goalItems[index]['title'],
                    description: goalItems[index]['description'],
                    progress: goalItems[index]['progress'],
                    iconColor: goalItems[index]['iconColor'],
                    iconData: goalItems[index]['iconData'],
                  );
                },
              )
            : const Center(child: Text("No goals found.")),
      ],
    );
  }

  Widget _buildTab(String text, int index) {
    final bool isSelected = _tabController.index == index;
    return Tab(
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(right: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? colorPrinciple : colorWhite,
          border: Border.all(color: colorPrinciple, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isSelected ? colorWhite : colorBlack),
        ),
      ),
    );
  }

  Widget _buildTodayTasks() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is SuccessHomeScreen) {
            if(state.taskToday.isNotEmpty){
                return Column(children: [_buildTodayTasksHeader(), _buildListTodayTasks()]);
            }
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildGoals() {
    return Column(children: [_buildHeadGoal(), _buildTabBar(),
    //  _buildListGoal()
     ]);
  }

  Widget _buildTodayTasksHeader() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Today's Task", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
          // IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildHeadGoal() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("List Goals", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
          // IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildListTodayTasks() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildTaskCard("Reading English", "Toeic 700-800", "18"),
          const SizedBox(width: 12),
          _buildTaskCard("Study English", "Toeic 700-800", "15"),
          const SizedBox(width: 12),
          _buildTaskCard("Do Homework", "Toeic 700-800", "25"),
          const SizedBox(width: 12),
          _buildTaskCard("Practice Speaking", "Toeic 700-800", "30"),
        ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String subtitle, String minutes) {
    const double cardWidth = 140;
    const double cardPadding = 10;
    const double cardBorderRadius = 10;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(horizontal: cardPadding / 2, vertical: cardPadding),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [BoxShadow(color: colorShadow.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: colorBlack,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Inter',
                  color: colorBlack,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(color: colorWhite, shape: BoxShape.circle),
                ),

                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    backgroundColor: colorLightGrey,
                    valueColor: const AlwaysStoppedAnimation<Color>(colorDarkYellow),
                    strokeWidth: 5,
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      minutes,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: colorBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "minutes",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: colorBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              print('Start');
            },
            child: Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(color: colorStartButton, borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Text(
                  "START",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter', color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
