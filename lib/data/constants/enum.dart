
enum TimeSheetStatus {
  inProgress,  // 1
  completed,   // 2
  deleted      // 3
}

extension TimeSheetStatusExtension on TimeSheetStatus {
  int get value {
    switch (this) {
      case TimeSheetStatus.inProgress:
        return 1;
      case TimeSheetStatus.completed:
        return 2;
      case TimeSheetStatus.deleted:
        return 3;
    }
  }
}


enum TaskStatus {
  inProgress,  // 1
  completed,   // 2
  deleted      // 3
}

extension TaskStatusExtension on TaskStatus {
  int get value {
    switch (this) {
      case TaskStatus.inProgress:
        return 1;
      case TaskStatus.completed:
        return 2;
      case TaskStatus.deleted:
        return 3;
    }
  }
}

enum GoalStatus {
  inProgress,  // 1
  completed,   // 2
  deleted      // 3
}

extension GoalStatusExtension on GoalStatus {
  int get value {
    switch (this) {
      case GoalStatus.inProgress:
        return 1;
      case GoalStatus.completed:
        return 2;
      case GoalStatus.deleted:
        return 3;
    }
  }
}
