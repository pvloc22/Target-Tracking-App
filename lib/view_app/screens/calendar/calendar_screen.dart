import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>CalendarBloc(),
    child:  CalendarForm(),);
  }
}
