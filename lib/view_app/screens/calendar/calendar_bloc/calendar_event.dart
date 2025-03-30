import 'package:flutter/cupertino.dart';

@immutable
abstract class CalendarEvent{
}

class CalendarWeekChange extends CalendarEvent{
  CalendarWeekChange();
}

class CalendarMonthChange extends CalendarEvent{
  CalendarMonthChange();
}
