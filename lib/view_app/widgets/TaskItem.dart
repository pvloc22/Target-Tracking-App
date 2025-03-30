
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final DateTime date;
  final TimeOfDay time;
  final String tag;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.date,
    required this.time,
    required this.tag,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (_) => onComplete(),
            backgroundColor: Color(0xFF56A23F).withOpacity(0.8),
            foregroundColor: Colors.white,
            icon: Icons.check_circle_outline,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(9)),
          ),
          SlidableAction(
            flex: 1,
            onPressed: (_) => onDelete(),
            backgroundColor: Color(0xFFD10000).withOpacity(0.8),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _circleTimeAndTitle(),
            SizedBox(height: 8),
            _shortTaskInformation()
          ],
        ),
      ),
    );
  }
  Widget _circleTimeAndTitle(){
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Color(0xFF3B6CBD).withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              '$duration ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF3B6CBD),
                fontSize: 8,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        SizedBox(width: 3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8B8E8D),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _shortTaskInformation(){
    return             Row(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16),
            SizedBox(width: 4),
            Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        SizedBox(width: 23),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF3B6CBD),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
        SizedBox(width: 23),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.red),
              SizedBox(width: 5),
              Text(
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? 'AM' : 'PM'}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

