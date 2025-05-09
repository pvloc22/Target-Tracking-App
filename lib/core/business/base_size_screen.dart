import 'package:flutter/cupertino.dart';

class BaseSizeScreen {
  static double responsiveHeightHeader(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 900) {
      return 100; // Small screen
    } else if (screenHeight < 1200) {
      return 150; // Medium screen
    } else {
      return 200; // Large screen
    }
  }
}