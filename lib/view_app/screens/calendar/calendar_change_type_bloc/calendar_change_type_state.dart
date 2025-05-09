
import 'package:flutter/material.dart';

@immutable
abstract class CalendarChangeTypeState {}

class CalendarTypeInitial extends  CalendarChangeTypeState {
  CalendarTypeInitial();
  List<Object?> get props => [];
}
class CalendarTypeWeek extends CalendarChangeTypeState {
  CalendarTypeWeek();
  List<Object?> get props => []; 
}

class CalendarTypeMonth extends CalendarChangeTypeState {
  CalendarTypeMonth();
  List<Object?> get props => [];
}