import 'package:app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:app/view_app/widgets/GoalItem.dart';
import 'package:app/view_app/widgets/TaskItem.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  _searchBar()
                ],
              ),
            ),
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorBorderGrey),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: colorWhite,
                unselectedLabelColor: colorTextGrey,
                indicator: BoxDecoration(
                  color: colorPrinciple,
                  borderRadius: BorderRadius.circular(12),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                padding: const EdgeInsets.all(4),
                tabs: const [
                  Tab(text: 'All Results'),
                  Tab(text: 'Tasks'),
                  Tab(text: 'Goals'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllResultsList(),
                  _buildTaskList(),
                  _buildGoalList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: SEARCH_PAGE_INDEX,
      ),
    );
  }

  Widget _buildAllResultsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                color: colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            TextButton(
              onPressed: () {
                _tabController.animateTo(1); // Switch to Tasks tab
              },
              child: Text(
                'See all',
                style: TextStyle(
                  color: colorPrinciple,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return TaskItem(
              title: 'Design App UI',
              description: 'Create a modern and clean UI design for the mobile app',
              duration: '2h',
              date: DateTime.now(),
              time: TimeOfDay.now(),
              tag: 'Design',
              onComplete: () {},
              onDelete: () {},
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Goals',
              style: TextStyle(
                color: colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            TextButton(
              onPressed: () {
                _tabController.animateTo(2); // Switch to Goals tab
              },
              child: Text(
                'See all',
                style: TextStyle(
                  color: colorPrinciple,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return GoalItem(
              title: 'Complete App Development',
              description: 'Finish all features and prepare for testing phase',
              iconBackgroundColor: colorLightGreen,
              icon: Icons.rocket_launch,
              onComplete: () {
                // Handle goal completion
              },
              onDelete: () {
                // Handle goal deletion
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return TaskItem(
          title: 'Design App UI',
          description: 'Create a modern and clean UI design for the mobile app',
          duration: '2h',
          date: DateTime.now(),
          time: TimeOfDay.now(),
          tag: 'Design',
          onComplete: () {},
          onDelete: () {},
        );
      },
    );
  }

  Widget _buildGoalList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return GoalItem(
          title: 'Complete App Development',
          description: 'Finish all features and prepare for testing phase',
          iconBackgroundColor: colorLightGreen,
          icon: Icons.rocket_launch,
          onComplete: () {
            // Handle goal completion
          },
          onDelete: () {
            // Handle goal deletion
          },
        );
      },
    );
  }

  Widget _searchBar(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: colorGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search tasks, goals...',
          hintStyle: TextStyle(
            color: colorTextGrey,
            fontSize: 14,
          ),
          prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
