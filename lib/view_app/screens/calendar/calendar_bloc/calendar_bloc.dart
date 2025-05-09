import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState>{

  CalendarBloc() : super(CalendarInitial()){
    on<CalendarFetch> (_calendarFetch);
  }

  void _calendarFetch(CalendarFetch event, Emitter emit) async{
    emit(CalendarProgressLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(CalendarLoaded());
  }

}

