import 'package:flutter/cupertino.dart';

@immutable
abstract class CalendarEvent{
  const CalendarEvent();
}

class CalendarChangeType extends CalendarEvent{
   final String typeCalendar;

  const CalendarChangeType({required this.typeCalendar});

}