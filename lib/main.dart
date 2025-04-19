import 'package:app/view_app/screens/auth/login_screen.dart';
import 'package:app/view_app/screens/auth/sign_up_screen.dart';
import 'package:app/view_app/screens/auth/verify_code_screen.dart';
import 'package:app/view_app/screens/calendar/calendar_screen.dart';
import 'package:app/view_app/screens/create_task/create_task_screen.dart';
import 'package:app/view_app/screens/goals/create_goal_screen.dart';
import 'package:app/view_app/screens/search/search_screen.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/firebase/firebase_options.dart';

import 'core/style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Target Tracking App',
      home: const CalendarScreen(),
      theme: ThemeData(
        fontFamily:'Inter',
        scaffoldBackgroundColor: colorWhite,
        useMaterial3: true,
      ),
    );
  }
}
