
import 'package:app/core/local_storage/base_sqlite.dart';
import 'package:app/data/model/goal_model.dart';
import 'package:sqflite/sqflite.dart';

class GoalService extends BaseSqlite {
  Future<List<Goal>> getGoalByStatus(int status, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'GOALS',
        where: 'status = ?',
        whereArgs: [status],
      );

      return List.generate(maps.length, (i) {
        return Goal.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Error fetching goals: $e');
    }
  }

  Future<Goal> getGoalById(int id, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'GOALS',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Goal.fromMap(maps.first);
      } else {
        throw Exception('Goal not found');
      }
    } catch (e) {
      throw Exception('Error fetching goal: $e');
    }
  }
  //Insert a new goal 
  Future<int> insertGoal(Goal goal, Database db) async {
    try {
      return await db.insert(
        'GOALS',
        goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Error inserting goal: $e');
    }
  }
  //Update a goal
  Future<int> updateGoal(Goal goal, Database db) async {
    try {
      return await db.update(
        'GOALS',
        goal.toMap(),
        where: 'id = ?',
        whereArgs: [goal.id],
      );
    } catch (e) {
      throw Exception('Error updating goal: $e');
    }
  }
  // Update status of a goal
  Future<int> updateGoalStatus(int id, int status, Database db) async {
    try {
      return await db.update(
        'GOALS',
        {'status': status},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Error updating goal status: $e');
    }
  }

  
}