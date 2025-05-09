  
import 'package:flutter/cupertino.dart';

@immutable
abstract class BottomNavigatorBarState {
  const BottomNavigatorBarState();
}

class BottomNavigatorBarInitial extends BottomNavigatorBarState {
  final int currentIndex;
  const BottomNavigatorBarInitial({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}

class BottomNavigatorBarCurrentIndexChanged extends BottomNavigatorBarState {
  final int currentIndex;

  const BottomNavigatorBarCurrentIndexChanged({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}

