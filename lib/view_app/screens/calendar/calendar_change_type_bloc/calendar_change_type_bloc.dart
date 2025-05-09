import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_event.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_state.dart';
import 'package:bloc/bloc.dart';

class CalendarChangeTypeBloc extends Bloc<CalendarChangeType, CalendarChangeTypeState> {
  CalendarChangeTypeBloc() : super(CalendarTypeInitial()) {
    on<CalendarChangeType>(_calendarChangeType);
  }

  void _calendarChangeType(CalendarChangeType event, Emitter emit) async {
    if (event.typeCalendar == MONTH_CALENDAR){
      emit(CalendarTypeMonth());
    }
    else{
      emit(CalendarTypeWeek());
    }
  }
}