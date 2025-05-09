import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_form.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_bloc/calendar_event.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider
    (providers:[
      BlocProvider(create: (context) => CalendarBloc()..add(CalendarFetch(dateTime: DateTime.now()))),
      BlocProvider(create: (context) => CalendarChangeTypeBloc())
    ],
    child: CalendarForm());
  }
}
