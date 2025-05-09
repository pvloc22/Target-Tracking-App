import 'package:app/core/local_storage/base_sqlite.dart';
import 'package:app/data/model/timesheet_model.dart';
import 'package:sqflite/sqflite.dart';

class TimeSheetService extends BaseSqlite {


  Future<void> insertTimeSheet(TimeSheet timeSheet, Database db) async {
    try {
      await db.insert('timesheet', timeSheet.toMap());
    } catch (e) {
      throw Exception('Error inserting timesheet: $e');
    }
  }

  Future<void> updateTimeSheet(TimeSheet timeSheet, Database db) async {
    try {
      await db.update('timesheet', timeSheet.toMap(), where: 'id = ?', whereArgs: [timeSheet.id]);
    } catch (e) {
      throw Exception('Error updating timesheet: $e');
    }
  }

  Future<void> updateStatusTimeSheet(int id, int status, Database db) async {
    try {
      await db.update('timesheet', {'status': status}, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Error updating timesheet status: $e');
    }
  }

  Future<List<TimeSheet>> getTimeSheetByTask(int id, int taskId, int idGoal, Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'timesheet',
        where: 'id_task = ? AND id_goal = ?',
        whereArgs: [taskId, idGoal],
      );

    return List.generate(maps.length, (i) {
      return TimeSheet.fromMap(maps[i]);
    });
    } catch (e) {
      throw Exception('Error fetching timesheet: $e');
    }
  }

  Future<int> totalDurationTimeSheetByTask(int taskId, int idGoal, Database db, int status) async {
    try {
      final result = await db.rawQuery(
        'SELECT SUM(duration) as total FROM timesheet WHERE id_task = ? AND id_goal = ? AND status = ?',
        [taskId, idGoal, status],
      );

      final total = result.first['total'];
      return total != null ? total as int : 0;
    } catch (e) {
      throw Exception('Error fetching timesheet total: $e');
    }
  }


  Future<int> totalDurationTimeSheetByGoal(int idGoal, Database db, int status) async {
    try {
      final result = await db.rawQuery(
        'SELECT SUM(duration) as total FROM timesheet WHERE id_goal = ? AND status = ?',
        [idGoal, status],
      );

      final total = result.first['total'];
      return total != null ? total as int : 0;
    } catch (e) {
      throw Exception('Error fetching timesheet total: $e');
    }
  }

}
