import 'package:app/view_app/screens/main/main_bloc/main_form.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_bloc.dart';

import '../../widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigatorBarBloc(),
      child: const MainForm(),
    );
  }
}
