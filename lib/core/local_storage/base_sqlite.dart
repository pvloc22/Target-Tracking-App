
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseSqlite {
  late String _databaseName;
  late int _databaseVersion;
  
  BaseSqlite(){
    _databaseName = 'target_tracking_database.db' ; 
    _databaseVersion = 1;
  }

  // ignore: unused_element
  Future<Database> initDatabase() async {
    try{
            // Ensure that the Flutter binding is initialized
      WidgetsFlutterBinding.ensureInitialized();
      // Get the database path
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, _databaseName);

      return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onOpen: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');     print('Database opened: $path');
      },
    );  
    }
    catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }
  void _onCreate(Database db, int version) async {
    await _createTable(db, version);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TASKS (
        id INTEGER,
        title TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL,
        start_date TEXT NOT NULL,
        start_time TEXT NOT NULL,
        status INTEGER NOT NULL,
        priority TEXT NOT NULL,
        reminder TEXT NOT NULL,
        expected_time TEXT NOT NULL,
        actual_time TEXT NOT NULL,
        created_at TEXT NOT NULL,
        IDGOALS INTEGER NOT NULL,
        PRIMARY KEY (id, IDGOALS),
        FOREIGN KEY (IDGOALS) REFERENCES GOALS (id) 

      )
    ''');

    await db.execute('''
      CREATE TABLE GOALS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        status INTEGER NOT NULL,
        reminder TEXT NOT NULL,
        expected_date TEXT NOT NULL,
        expected_time TEXT NOT NULL,
        actual_time TEXT NULL,
        created_at TEXT NOT NULL,
      )
    ''');

    await db.execute('''
      CREATE TABLE TIMESHEETS (
        id INTEGER, 
        id_task INTEGER NOT NULL,
        id_goal INTEGER NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        duration DOUBLE NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL,

        PRIMARY KEY (id, id_task, id_goal),
        FOREIGN KEY (id_task) REFERENCES TASKS (id),
        FOREIGN KEY (id_goal) REFERENCES GOALS (id)
      )
    ''');
  }


  
}