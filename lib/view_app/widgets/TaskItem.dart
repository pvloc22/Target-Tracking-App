import 'package:app/view_app/screens/detail_task/task_summary_screen.dart';
import 'package:app/view_app/screens/detail_task/watch_task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:app/core/style/colors.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final DateTime date;
  final TimeOfDay time;
  final String? tagGoal;
  final bool isCompleted;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.date,
    required this.time,
    this.tagGoal,
    required this.onComplete,
    required this.onDelete,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SizedBox(width: 3),
          SlidableAction(
            flex: 1,
            onPressed: (_) => onComplete(),
            backgroundColor: colorTaskGreen.withOpacity(0.8),
            foregroundColor: colorWhite,
            icon: Icons.check_circle_outline,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(9)),
          ),
          SizedBox(width: 3),
          SlidableAction(
            flex: 1,
            onPressed: (_) => onDelete(),
            backgroundColor: colorTaskRed.withOpacity(0.8),
            foregroundColor: colorWhite,
            icon: Icons.delete_forever,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => isCompleted 
                ? const TaskSummaryScreen() 
                : const WatchTaskScreen()
            )
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: colorShadow, offset: Offset(0, 4), blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_circleTimeAndTitle(), SizedBox(height: 8), _shortTaskInformation()],
          ),
        ),
      ),
    );
  }

  Widget _circleTimeAndTitle() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(color: colorTaskBlue.withOpacity(0.1), shape: BoxShape.circle),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: 0.75, // You might want to make this a parameter
                  backgroundColor: colorTaskBlue.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(colorTaskBlue),
                  strokeWidth: 4,
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child:
                      isCompleted
                          ? Icon(Icons.check, color: colorTaskBlue, size: 20)
                          : Text(
                            duration,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: colorTaskBlue, fontSize: 8),
                          ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter', color: colorBlack),
              ),
              const SizedBox(height: 4),
              Text(description, style: TextStyle(fontSize: 12, color: colorGrey, fontFamily: 'Inter')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shortTaskInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: colorBlack),
            SizedBox(width: 4),
            Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: colorBlack),
            ),
          ],
        ),
        tagGoal == null
            ? Container()
            : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(color: colorTaskBlue, borderRadius: BorderRadius.circular(10)),
              child: Text(
                tagGoal!,
                style: TextStyle(color: colorWhite, fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
              ),
            ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(border: Border.all(color: colorRed), borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: colorRed),
              SizedBox(width: 5),
              Text(
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? 'AM' : 'PM'}',
                style: TextStyle(color: colorRed, fontSize: 10, fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
