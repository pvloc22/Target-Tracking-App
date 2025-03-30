import 'package:flutter/material.dart';

import '../../../../core/style/colors.dart';
import '../../../../data/constants/constants.dart';

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
    if (selectedValue is String) {
      setState(() {
        _selectedValue = selectedValue;
        // widget.onPressed(_selectedValue!);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text('Calendar', style: TextStyle(fontWeight: FontWeight.bold, color: colorWhite)),
      backgroundColor: colorPrinciple,
      actions: [
        DropdownButton(
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
        ),
      ],
    );
  }
}
