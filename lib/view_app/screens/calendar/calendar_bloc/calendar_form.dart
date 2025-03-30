import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/calendar/widgets/appbar_calendar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/style/colors.dart';

class CalendarForm extends StatefulWidget {
  const CalendarForm({super.key});

  @override
  State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> {
  DateTime _today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCalendar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
            children: [
              // _buildCalendarMonth(),
              _buildCalendarWeek(),
              _buildListTask()]
        ),
      ),
    );
  }
  Widget _buildCalendarWeek() {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only( bottom: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // màu của bóng
            spreadRadius: 5, // phân tán bóng
            blurRadius: 7, // độ mờ của bóng
            offset: Offset(0, 3), // vị trí của bóng
          ),
        ],
      ),
      child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          print('$selectedDate');
        },
        activeColor: const Color(0xff37306B),
        headerProps: const EasyHeaderProps(
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
        ),
        dayProps: const EasyDayProps(
          activeDayStyle: DayStyle(
            borderRadius: 32.0,
          ),
          inactiveDayStyle: DayStyle(
            borderRadius: 32.0,
          ),
        ),
        timeLineProps: const EasyTimeLineProps(
          hPadding: 16.0, // padding from left and right
          separatorPadding: 16.0, // padding between days
        ),
      )
    );
  }

  Widget _buildCalendarMonth() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // màu của bóng
            spreadRadius: 5, // phân tán bóng
            blurRadius: 7, // độ mờ của bóng
            offset: Offset(0, 3), // vị trí của bóng
          ),
        ],
      ),
      child: TableCalendar(
        locale: 'en_US',
        rowHeight: 40,
        focusedDay: _today,
        firstDay: DateTime.utc(2020, 8, 4),
        lastDay: DateTime.utc(2030, 8, 4),
        headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, _today),
        onDaySelected: _onDaySelected,
      ),
    );
  }

  Widget _buildListTask() {
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              children: [
                _titleTasksOfDay(),
                _listTasks()]
          ),
        )
    );
  }
  Widget _titleTasksOfDay() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('List Task', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: colorBlack)),
          Image(width: 24, height: 24, image: AssetImage('assets/images/more-horizontal.png')),
        ],
      ),
    );
  }

  Widget _listTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Text('fafa');
        },
      ),
    );
  }
}
