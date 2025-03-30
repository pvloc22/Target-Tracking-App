import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:app/view_app/screens/calendar/widgets/appbar_calendar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/style/colors.dart';
import '../../../widgets/TaskItem.dart';

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
            BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state is CalendarTypeMonth) {
                  return _buildCalendarMonth();
                } else {
                  return _buildCalendarWeek();
                }
              },
            ),
            _buildListTask(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarWeek() {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 20),
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
          activeDayStyle: DayStyle(borderRadius: 32.0),
          inactiveDayStyle: DayStyle(borderRadius: 32.0),
        ),
        timeLineProps: const EasyTimeLineProps(
          hPadding: 16.0, // padding from left and right
          separatorPadding: 16.0, // padding between days
        ),
      ),
    );
  }

  Widget _buildCalendarMonth() {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
        child: Column(children: [_titleTasksOfDay(), _listTasks()]),
      ),
    );
  }

  Widget _titleTasksOfDay() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('List Task', 
            style: const TextStyle(
              fontWeight: FontWeight.w900, 
              fontSize: 25, 
              color: colorBlack
            )
          ),
          PopupMenuButton(
            icon: Image(
              width: 24, 
              height: 24, 
              image: AssetImage('assets/images/more-horizontal.png')
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'view',
                child: Row(
                  children: [
                    Icon(Icons.view_agenda_outlined, color: colorBlack),
                    SizedBox(width: 8),
                    Text('Change View'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'filter',
                child: Row(
                  children: [
                    Icon(Icons.filter_list, color: colorBlack),
                    SizedBox(width: 8),
                    Text('Filter Tasks'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'sort',
                child: Row(
                  children: [
                    Icon(Icons.sort, color: colorBlack),
                    SizedBox(width: 8),
                    Text('Sort By'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'add',
                child: Row(
                  children: [
                    Icon(Icons.add_task, color: colorBlack),
                    SizedBox(width: 8),
                    Text('Add New Task'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'view':
                  context.read<CalendarBloc>().add(
                    CalendarChangeType(
                      typeCalendar: context.read<CalendarBloc>().state is CalendarTypeMonth 
                        ? WEEK_CALENDAR 
                        : MONTH_CALENDAR
                    )
                  );
                  break;
                case 'filter':
                  _showFilterDialog(context);
                  break;
                case 'sort':
                  _showSortDialog(context);
                  break;
                case 'add':
                  _showAddTaskDialog(context);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Tasks'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: Text('Completed Tasks'),
                value: false,
                onChanged: (bool? value) {
                  // Implement filter logic
                  Navigator.pop(context);
                },
              ),
              CheckboxListTile(
                title: Text('Pending Tasks'),
                value: true,
                onChanged: (bool? value) {
                  // Implement filter logic
                  Navigator.pop(context);
                },
              ),
              CheckboxListTile(
                title: Text('Important Tasks'),
                value: false,
                onChanged: (bool? value) {
                  // Implement filter logic
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Apply'),
              onPressed: () {
                // Implement apply filter logic
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort By'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('Date (Newest First)'),
                value: 'date_desc',
                groupValue: 'date_desc',
                onChanged: (value) {
                  // Implement sort logic
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: Text('Date (Oldest First)'),
                value: 'date_asc',
                groupValue: 'date_desc',
                onChanged: (value) {
                  // Implement sort logic
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: Text('Duration'),
                value: 'duration',
                groupValue: 'date_desc',
                onChanged: (value) {
                  // Implement sort logic
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Apply'),
              onPressed: () {
                // Implement apply sort logic
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Tag',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Implement add task logic
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _listTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TaskItem(
              title: 'Save \$50,000',
              description: 'By saving at least 100 minimum; a month before retirement',
              duration: '40 Minutes',
              date: DateTime(2025, 3, 11),
              time: TimeOfDay(hour: 10, minute: 0),
              tag: 'Help the needy',
              onComplete: () {
                // Handle complete action
                print('Task completed');
              },
              onDelete: () {
                // Handle delete action
                print('Task deleted');
              },
            ),
          );
        },
      ),
    );
  }
}
