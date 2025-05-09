import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../core/style/colors.dart';
import '../screens/goals/detail_goal_screen.dart';

class GoalItem extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final Color iconColor;
  final IconData iconData;
  final VoidCallback? onComplete;
  final VoidCallback? onDelete;

  const GoalItem({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.iconColor,
    required this.iconData,
    this.onComplete,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 3),
          SlidableAction(
            flex: 1,
            onPressed: (_) => onComplete?.call(),
            backgroundColor: colorTaskGreen.withOpacity(0.8),
            foregroundColor: colorWhite,
            icon: Icons.check_circle_outline,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(9)),
          ),
          const SizedBox(width: 3),
          SlidableAction(
            flex: 1,
            onPressed: (_) => onDelete?.call(),
            backgroundColor: colorTaskRed.withOpacity(0.8),
            foregroundColor: colorWhite,
            icon: Icons.delete_outline,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(9)),
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGoalScreen()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: colorShadow.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              _buildProgressIndicator(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: colorGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: progress,
              backgroundColor: iconColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(iconColor),
              strokeWidth: 4,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
} 