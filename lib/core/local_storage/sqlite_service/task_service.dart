import 'package:app/data/model/task_model.dart';
import 'package:sqflite/sqlite_api.dart';

import '../base_sqlite.dart';

class TaskService extends BaseSqlite {
  Future<Task> getTaskById(int id, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'TASKS',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Task.fromMap(maps.first);
      } else {
        throw Exception('Task not found');
      }
    } catch (e) {
      throw Exception('Error fetching task: $e');
    }
  }
  
  Future<List<Task>> getTaskAtDate(String date, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'TASKS',
        where: 'start_date = ?',
        whereArgs: [date],
      );

      return List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }  

// get all task today with complete status
Future<List<Task>> getTaskToday(Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'TASKS',
        where: 'start_date = ? AND status = ?',
        whereArgs: [DateTime.now().toString(), 1],
      );

      return List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  Future<List<Task>> getTaskByGoalIdAtDate(int idGoal, String date, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'TASKS',
        where: 'IDGOALS = ? AND start_date = ?',
        whereArgs: [idGoal, date],
      );

      return List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
  Future<List<Task>> getTasksFromDateToDate(String startDate, String endDate, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'TASKS',
        where: 'start_date BETWEEN ? AND ?',
        whereArgs: [startDate, endDate],
      );

      return List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  //Insert a task
  Future<int> insertTask(Task task, Database db) async {
    try {
      return await db.insert(
        'TASKS',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Error inserting task: $e');
    }
  }
  //Update a task
  Future<int> updateTask(Task task, Database db) async {
    // to identify the task that needs to transmit the idGoals and the idTask
    try {
      return await db.update(
        'TASKS',
        task.toMap(),
        where: 'id = ? AND idGoals = ?',
        whereArgs: [task.id, task.idGoals],
      );
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }
  //Delete a task 
  Future<int> deleteTask(Task task, Database db) async {
    try {
      return await db.update(
        'TASKS',
        {'status': 0},
        where: 'id = ? AND idGoals = ?',
        whereArgs: [task.id, task.idGoals],
      );
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }
}

