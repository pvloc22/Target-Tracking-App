import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState>{

  CalendarBloc() : super(CalendarInitial()){
    on<CalendarChangeType> (_calendarWeekType);
  }

  void _calendarWeekType(CalendarChangeType event, Emitter emit){
    if(event.typeCalendar == MONTH_CALENDAR) {
      emit(CalendarTypeMonth());
    } else {
      emit(CalendarTypeWeek());
    }
  }


}

