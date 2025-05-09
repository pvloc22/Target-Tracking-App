import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState extends Equatable{
  @override
  List<Object?> get props => [];

}

class CalendarInitial extends CalendarState{
  @override
  List<Object?> get props => [];
}
class CalendarProgressLoading extends CalendarState{
  @override
  List<Object?> get props => [];
}
class CalendarLoaded extends CalendarState{
  // final List<DateTime> listDate;
  // final DateTime dateTime;
  // final String typeCalendar;
  // const CalendarLoaded({required this.listDate, required this.dateTime, required this.typeCalendar});
  // @override
  // List<Object?> get props => [listDate, dateTime, typeCalendar];
  @override
  List<Object?> get props => [];
}