
import 'package:sqflite/sqflite.dart';

import '../../core/local_storage/sqlite_service/goal_service.dart';
import '../../core/local_storage/sqlite_service/task_service.dart';
import '../model/goal_model.dart';

class HomeRepository {
    final GoalService goalService = GoalService();
    final TaskService taskService = TaskService();

    Future<List<Goal>> getGoalsbyStatus(int status, int idGoal) async {
        Database db = await goalService.initDatabase();
        return goalService.getGoalByStatus(status, db); 
    }
}