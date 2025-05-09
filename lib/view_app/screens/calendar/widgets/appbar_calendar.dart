import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/colors.dart';
import '../../../../data/constants/constants.dart';
import '../calendar_change_type_bloc/calendar_change_type_event.dart';

class AppbarCalendar extends StatefulWidget implements PreferredSizeWidget{
  const AppbarCalendar({super.key});

  @override
  State<AppbarCalendar> createState() => _AppbarCalendarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _AppbarCalendarState extends State<AppbarCalendar> {
  String? _selectedValue;

  void dropDownCallBack(String? selectedValue) {
    if (selectedValue is String &&  selectedValue == WEEK_CALENDAR) {
      _selectedValue = WEEK_CALENDAR;
      print(_selectedValue);
      context.read<CalendarChangeTypeBloc>().add(CalendarChangeType(typeCalendar: WEEK_CALENDAR));
    }
    else {
      _selectedValue = MONTH_CALENDAR;
      print(_selectedValue);
      context.read<CalendarChangeTypeBloc>().add(CalendarChangeType(typeCalendar: MONTH_CALENDAR));
    }
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text('Calendar', style: TextStyle(fontWeight: FontWeight.bold, color: colorWhite)),
      backgroundColor: colorPrinciple,
      actions: [
        BlocBuilder<CalendarChangeTypeBloc, CalendarChangeTypeState>(builder:(context, state){
          return _dropdownButton();
        })
      ],
    );
  }

  Widget _dropdownButton(){
    return DropdownButton(
      value: _selectedValue ?? WEEK_CALENDAR,
      dropdownColor: colorPrinciple,
      underline: Container(),
      iconSize: 40,
      iconEnabledColor: colorWhite,
      style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
      items: const [
        DropdownMenuItem<String>(
          value: WEEK_CALENDAR,
          child: Text('Week', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DropdownMenuItem<String>(
          value: MONTH_CALENDAR,
          child: Text('Month', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      onChanged: dropDownCallBack,
    );
  }
}
