import 'package:flutter/material.dart';

@immutable
abstract class CalendarChangeTypeEvent {

}

class CalendarChangeType extends CalendarChangeTypeEvent {
  final String typeCalendar;
  CalendarChangeType({required this.typeCalendar});
}