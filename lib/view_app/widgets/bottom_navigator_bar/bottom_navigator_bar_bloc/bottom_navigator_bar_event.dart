import 'package:flutter/cupertino.dart';

@immutable
abstract class BottomNavigatorBarEvent {
  const BottomNavigatorBarEvent();
}

class BottomNavChanged extends BottomNavigatorBarEvent {
  final int currentIndex;

  const BottomNavChanged({required this.currentIndex});
}
