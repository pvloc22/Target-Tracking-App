import 'package:app/view_app/screens/auth/login_screen.dart';
import 'package:app/view_app/screens/auth/sign_up_screen.dart';
import 'package:app/view_app/screens/auth/verify_code_screen.dart';
import 'package:app/view_app/screens/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';

import 'core/style/colors.dart';

void main() {
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
      home: const LoginScreen(),
      theme: ThemeData(
        // fontFamily: GoogleFonts.getFont(kDefaultFontFamily).fontFamily,
        scaffoldBackgroundColor: colorWhite,
        useMaterial3: true,
      ),
    );
  }
}
