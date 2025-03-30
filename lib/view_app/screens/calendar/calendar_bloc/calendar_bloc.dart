import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState>{

  CalendarBloc() : super(CalendarInitial()){
    on<CalendarWeekChange> (_calendarWeekType);
    on<CalendarMonthChange> (_calendarMonthType);
  }

  void _calendarWeekType(CalendarWeekChange event, Emitter emit){
    emit(CalendarTypeWeek());
  }

  void _calendarMonthType(CalendarMonthChange event, Emitter emit){
    emit(CalendarTypeWeek());
  }
}

