import 'package:app/data/constants/constants.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_event.dart';
import 'package:app/view_app/screens/calendar/calendar_bloc/calendar_state.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_bloc.dart';
import 'package:app/view_app/screens/calendar/calendar_change_type_bloc/calendar_change_type_state.dart';
import 'package:app/view_app/screens/calendar/widgets/appbar_calendar.dart';
import 'package:app/view_app/screens/create_task/create_task_screen.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/style/colors.dart';
import '../../../widgets/TaskItem.dart';
import '../../../widgets/bottom_navigator_bar/bottom_navigator_bar.dart';

class CalendarForm extends StatefulWidget {
  const CalendarForm({super.key});

  @override
  State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> with SingleTickerProviderStateMixin {
  DateTime _today = DateTime.now();
  bool _showCompletedTasks = true;
  bool _showPendingTasks = true;
  bool _showImportantTasks = false;
  String _currentSortOption = 'date_desc';
  // late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   duration: const Duration(milliseconds: 300),
    //   vsync: this,
    // );
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

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
        child: Column(
          children: [
            BlocBuilder<CalendarChangeTypeBloc, CalendarChangeTypeState>(
              builder: (context, state) {
                if (state is CalendarTypeMonth) {
                  return _buildCalendarMonth();
                } else {
                  return _buildCalendarWeek();
                }
              },
            ),
            BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  if(state is CalendarProgressLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state is CalendarLoaded){
                    return _buildListTask();
                  }
                  else{
                    return Center(
                      child: Text('error'),
                    );
                  }
                }
                )
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
            color: colorGrey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          setState(() {
            _today = selectedDate;
          });
        },
        activeColor: colorCalendarActive,
        headerProps: const EasyHeaderProps(
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
        ),
        dayProps: const EasyDayProps(
          activeDayStyle: DayStyle(borderRadius: 32.0),
          inactiveDayStyle: DayStyle(borderRadius: 32.0),
        ),
        timeLineProps: const EasyTimeLineProps(
          hPadding: 16.0,
          separatorPadding: 16.0,
        ),
      ),
    );
  }

  Widget _buildCalendarMonth() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      margin: EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorGrey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
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
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 12),
          weekendStyle: TextStyle(fontSize: 12, color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildListTask() {
    return Expanded(
      child: Column(children: [_titleTasksOfDay(), _listTasks()]),
    );
  }

  Widget _titleTasksOfDay() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tasks for ${_today.day}/${_today.month}/${_today.year}',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: colorBlack
            )
          ),
          // _buildMoreMenu(),
        ],
      ),
    );
  }

  // Widget _buildMoreMenu() {
  //   return Theme(
  //     data: Theme.of(context).copyWith(
  //       popupMenuTheme: PopupMenuThemeData(
  //         elevation: 8,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         textStyle: TextStyle(
  //           color: colorBlack,
  //           fontSize: 14,
  //           fontFamily: 'Inter',
  //         ),
  //       ),
  //     ),
  //     child: PopupMenuButton(
  //       offset: Offset(0, 40),
  //       position: PopupMenuPosition.under,
  //       icon: Container(
  //         padding: EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: colorPrinciple.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: RotationTransition(
  //           turns: Tween(begin: 0.0, end: 0.0625)
  //             .animate(_animationController),
  //           child: Icon(
  //             Icons.more_horiz,
  //             color: colorPrinciple,
  //             size: 24,
  //           ),
  //         ),
  //       ),
  //       onOpened: () {
  //         _animationController.forward();
  //       },
  //       onCanceled: () {
  //         _animationController.reverse();
  //       },
  //       onSelected: (value) {
  //         _animationController.reverse();
  //         switch (value) {
  //           case 'view':
  //             context.read<CalendarBloc>().add(
  //               CalendarChangeType(
  //                 typeCalendar: context.read<CalendarBloc>().state is CalendarTypeMonth
  //                   ? WEEK_CALENDAR
  //                   : MONTH_CALENDAR
  //               )
  //             );
  //             break;
  //           case 'filter':
  //             _showFilterDialog(context);
  //             break;
  //           case 'sort':
  //             _showSortDialog(context);
  //             break;
  //           case 'add':
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => CreateTaskScreen()),
  //             );
  //             break;
  //           case 'export':
  //             _showExportDialog(context);
  //             break;
  //           case 'share':
  //             _showShareOptionsDialog(context);
  //             break;
  //         }
  //       },
  //       itemBuilder: (BuildContext context) => [
  //         _buildPopupMenuItem(
  //           value: 'view',
  //           icon: Icons.view_agenda_outlined,
  //           text: context.read<CalendarBloc>().state is CalendarTypeMonth
  //             ? 'Switch to Week View'
  //             : 'Switch to Month View',
  //           color: colorBlue,
  //         ),
  //         _buildPopupMenuItem(
  //           value: 'filter',
  //           icon: Icons.filter_list,
  //           text: 'Filter Tasks',
  //           color: colorDarkYellow,
  //         ),
  //         _buildPopupMenuItem(
  //           value: 'sort',
  //           icon: Icons.sort,
  //           text: 'Sort By',
  //           color: colorDarkPink,
  //         ),
  //         _buildPopupMenuItem(
  //           value: 'add',
  //           icon: Icons.add_task,
  //           text: 'Create New Task',
  //           color: colorTaskGreen,
  //         ),
  //         _buildPopupMenuItem(
  //           value: 'export',
  //           icon: Icons.file_download_outlined,
  //           text: 'Export Calendar',
  //           color: colorBlueMint,
  //         ),
  //         _buildPopupMenuItem(
  //           value: 'share',
  //           icon: Icons.share,
  //           text: 'Share Schedule',
  //           color: colorPrinciple,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // PopupMenuItem _buildPopupMenuItem({
  //   required String value,
  //   required IconData icon,
  //   required String text,
  //   required Color color,
  // }) {
  //   return PopupMenuItem(
  //     value: value,
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             color: color.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Icon(icon, color: color, size: 18),
  //         ),
  //         SizedBox(width: 12),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontFamily: 'Inter',
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void _showFilterDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Row(
  //               children: [
  //                 Icon(Icons.filter_list, color: colorDarkYellow),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   'Filter Tasks',
  //                   style: TextStyle(
  //                     color: colorBlack,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Inter',
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 _buildFilterTile(
  //                   title: 'Completed Tasks',
  //                   value: _showCompletedTasks,
  //                   icon: Icons.check_circle,
  //                   color: colorTaskGreen,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _showCompletedTasks = value!;
  //                     });
  //                   },
  //                 ),
  //                 _buildFilterTile(
  //                   title: 'Pending Tasks',
  //                   value: _showPendingTasks,
  //                   icon: Icons.pending_actions,
  //                   color: colorDarkYellow,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _showPendingTasks = value!;
  //                     });
  //                   },
  //                 ),
  //                 _buildFilterTile(
  //                   title: 'Important Tasks',
  //                   value: _showImportantTasks,
  //                   icon: Icons.star,
  //                   color: colorDarkPink,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _showImportantTasks = value!;
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: Text(
  //                   'Cancel',
  //                   style: TextStyle(color: colorGrey),
  //                 ),
  //                 onPressed: () => Navigator.pop(context),
  //               ),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: colorDarkYellow,
  //                   foregroundColor: colorWhite,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //                 child: Text('Apply Filters'),
  //                 onPressed: () {
  //                   // Implement apply filter logic
  //                   this.setState(() {});
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           );
  //         }
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildFilterTile({
  //   required String title,
  //   required bool value,
  //   required IconData icon,
  //   required Color color,
  //   required Function(bool?) onChanged,
  // }) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 4),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: color.withOpacity(0.05),
  //     ),
  //     child: CheckboxListTile(
  //       title: Row(
  //         children: [
  //           Icon(icon, color: color, size: 20),
  //           SizedBox(width: 10),
  //           Text(
  //             title,
  //             style: TextStyle(
  //               fontFamily: 'Inter',
  //               fontWeight: FontWeight.w500,
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //       value: value,
  //       activeColor: color,
  //       checkColor: colorWhite,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       onChanged: onChanged,
  //     ),
  //   );
  // }
  //
  // void _showSortDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Row(
  //               children: [
  //                 Icon(Icons.sort, color: colorDarkPink),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   'Sort Tasks',
  //                   style: TextStyle(
  //                     color: colorBlack,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Inter',
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 _buildSortTile(
  //                   title: 'Date (Newest First)',
  //                   value: 'date_desc',
  //                   groupValue: _currentSortOption,
  //                   icon: Icons.arrow_downward,
  //                   color: colorBlue,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _currentSortOption = value.toString();
  //                     });
  //                   },
  //                 ),
  //                 _buildSortTile(
  //                   title: 'Date (Oldest First)',
  //                   value: 'date_asc',
  //                   groupValue: _currentSortOption,
  //                   icon: Icons.arrow_upward,
  //                   color: colorBlue,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _currentSortOption = value.toString();
  //                     });
  //                   },
  //                 ),
  //                 _buildSortTile(
  //                   title: 'Duration (Shortest First)',
  //                   value: 'duration_asc',
  //                   groupValue: _currentSortOption,
  //                   icon: Icons.hourglass_bottom,
  //                   color: colorTaskRed,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _currentSortOption = value.toString();
  //                     });
  //                   },
  //                 ),
  //                 _buildSortTile(
  //                   title: 'Duration (Longest First)',
  //                   value: 'duration_desc',
  //                   groupValue: _currentSortOption,
  //                   icon: Icons.hourglass_top,
  //                   color: colorTaskRed,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _currentSortOption = value.toString();
  //                     });
  //                   },
  //                 ),
  //                 _buildSortTile(
  //                   title: 'Alphabetical (A to Z)',
  //                   value: 'alpha_asc',
  //                   groupValue: _currentSortOption,
  //                   icon: Icons.sort_by_alpha,
  //                   color: colorDarkPink,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _currentSortOption = value.toString();
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: Text(
  //                   'Cancel',
  //                   style: TextStyle(color: colorGrey),
  //                 ),
  //                 onPressed: () => Navigator.pop(context),
  //               ),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: colorDarkPink,
  //                   foregroundColor: colorWhite,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //                 child: Text('Apply Sorting'),
  //                 onPressed: () {
  //                   // Implement apply sort logic
  //                   this.setState(() {});
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           );
  //         }
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildSortTile({
  //   required String title,
  //   required String value,
  //   required String groupValue,
  //   required IconData icon,
  //   required Color color,
  //   required Function(Object?) onChanged,
  // }) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 4),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: value == groupValue ? color.withOpacity(0.1) : Colors.transparent,
  //     ),
  //     child: RadioListTile(
  //       title: Row(
  //         children: [
  //           Icon(icon, color: color, size: 20),
  //           SizedBox(width: 10),
  //           Text(
  //             title,
  //             style: TextStyle(
  //               fontFamily: 'Inter',
  //               fontWeight: FontWeight.w500,
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //       value: value,
  //       groupValue: groupValue,
  //       activeColor: color,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       onChanged: onChanged,
  //     ),
  //   );
  // }
  //
  // void _showExportDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.file_download_outlined, color: colorBlueMint),
  //             SizedBox(width: 10),
  //             Text(
  //               'Export Calendar',
  //               style: TextStyle(
  //                 color: colorBlack,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Inter',
  //               ),
  //             ),
  //           ],
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             _buildExportOption(
  //               icon: Icons.picture_as_pdf,
  //               color: colorTaskRed,
  //               title: 'Export as PDF',
  //               description: 'Create a PDF document with all tasks',
  //             ),
  //             SizedBox(height: 12),
  //             _buildExportOption(
  //               icon: Icons.calendar_today,
  //               color: colorBlue,
  //               title: 'Export to Calendar',
  //               description: 'Add these events to your device calendar',
  //             ),
  //             SizedBox(height: 12),
  //             _buildExportOption(
  //               icon: Icons.save_alt,
  //               color: colorTaskGreen,
  //               title: 'Save as CSV',
  //               description: 'Export task data in spreadsheet format',
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(color: colorGrey),
  //             ),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildExportOption({
  //   required IconData icon,
  //   required Color color,
  //   required String title,
  //   required String description,
  // }) {
  //   return InkWell(
  //     onTap: () {
  //       // Implement export functionality
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Exporting as $title'),
  //           backgroundColor: color,
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: color.withOpacity(0.3)),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: color.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(icon, color: color),
  //           ),
  //           SizedBox(width: 16),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 14,
  //                     fontFamily: 'Inter',
  //                   ),
  //                 ),
  //                 Text(
  //                   description,
  //                   style: TextStyle(
  //                     color: colorGrey,
  //                     fontSize: 12,
  //                     fontFamily: 'Inter',
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // void _showShareOptionsDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: [
  //             Icon(Icons.share, color: colorPrinciple),
  //             SizedBox(width: 10),
  //             Text(
  //               'Share Schedule',
  //               style: TextStyle(
  //                 color: colorBlack,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Inter',
  //               ),
  //             ),
  //           ],
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Enter email address',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 prefixIcon: Icon(Icons.email),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 _buildShareOption(
  //                   icon: Icons.messenger_outline,
  //                   color: colorBlue,
  //                   label: 'Message',
  //                 ),
  //                 _buildShareOption(
  //                   icon: Icons.chat_bubble_outline,
  //                   color: colorTaskGreen,
  //                   label: 'WhatsApp',
  //                 ),
  //                 _buildShareOption(
  //                   icon: Icons.link,
  //                   color: colorDarkPink,
  //                   label: 'Copy Link',
  //                 ),
  //                 _buildShareOption(
  //                   icon: Icons.more_horiz,
  //                   color: colorGrey,
  //                   label: 'More',
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(color: colorGrey),
  //             ),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: colorPrinciple,
  //               foregroundColor: colorWhite,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             child: Text('Share'),
  //             onPressed: () {
  //               // Implement share logic
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                   content: Text('Calendar shared successfully!'),
  //                   backgroundColor: colorPrinciple,
  //                   behavior: SnackBarBehavior.floating,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildShareOption({
  //   required IconData icon,
  //   required Color color,
  //   required String label,
  // }) {
  //   return InkWell(
  //     onTap: () {
  //       // Implement share functionality
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Sharing via $label'),
  //           backgroundColor: color,
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //       );
  //     },
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //             color: color.withOpacity(0.1),
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(icon, color: color),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontFamily: 'Inter',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  Widget _listTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return TaskItem(
            title: 'Save \$50,000',
            description: 'By saving at least 100 minimum; a month before retirement',
            duration: '40 Minutes',
            date: DateTime(2025, 3, 11),
            time: TimeOfDay(hour: 10, minute: 0),
            tagGoal: 'Help the needy',
            isCompleted: false,
            onComplete: () {
              // Handle complete action
              print('Task completed');
            },
            onDelete: () {
              // Handle delete action
              print('Task deleted');
            },
          );
        },
      ),
    );
  }
}
