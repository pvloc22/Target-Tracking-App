import 'package:app/view_app/screens/analyst/analyst_screen.dart';
import 'package:app/view_app/screens/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_bloc.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_state.dart';
import 'package:app/view_app/screens/home/home_screen.dart';
import 'package:app/view_app/screens/search/search_screen.dart';
import 'package:app/view_app/screens/profile/profile_screen.dart';

import '../../../widgets/bottom_navigator_bar/bottom_navigator_bar.dart';

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigatorBarBloc, BottomNavigatorBarState>(
        builder: (context, state) {
          if(state is BottomNavigatorBarCurrentIndexChanged) {
            return switch(state.currentIndex) {
              0 => const HomeScreen(),
              1 => const CalendarScreen(),
              2 => const SearchScreen(),
              4 => const AnalystScreen(),
              _ => const HomeScreen(),
            };
          }
          return const HomeScreen();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigatorBarBloc, BottomNavigatorBarState>(
        builder: (context, state) {
          return CustomBottomNavigationBar(
            currentIndex: state is BottomNavigatorBarCurrentIndexChanged ? state.currentIndex : 0,
          );
        },
      ),
    );
  }
}
