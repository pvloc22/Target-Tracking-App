import 'package:flutter/cupertino.dart';

@immutable
abstract class CalendarEvent{
  const CalendarEvent();
}

class CalendarFetch extends CalendarEvent{
  final DateTime dateTime;
  const CalendarFetch({required this.dateTime});
}