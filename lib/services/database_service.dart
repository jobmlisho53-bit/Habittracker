import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/habit.dart';

class DatabaseService {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase async {
    String path = join(await getDatabasesPath(), 'trader.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }
  
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE daily_routines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        activity TEXT,
        start_time TEXT,
        end_time TEXT,
        completed INTEGER,
        date TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    
    await db.execute('''
      CREATE TABLE trading_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_number INTEGER,
        start_time TEXT,
        end_time TEXT,
        pair TEXT,
        lot_size REAL,
        pips_target INTEGER,
        profit_loss REAL,
        notes TEXT,
        date TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
  
  Future<int> insertHabit(DailyRoutine habit) async {
    final db = await database;
    return await db.insert('daily_routines', habit.toMap());
  }
  
  Future<int> updateHabit(DailyRoutine habit) async {
    final db = await database;
    return await db.update(
      'daily_routines',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }
  
  Future<List<DailyRoutine>> getTodaysHabits(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'daily_routines',
      where: 'date = ?',
      whereArgs: [date],
      orderBy: 'start_time',
    );
    
    return List.generate(maps.length, (i) {
      return DailyRoutine.fromMap(maps[i]);
    });
  }
  
  Future<void> insertTodaysSchedule(List<DailyRoutine> schedule) async {
    final db = await database;
    for (var habit in schedule) {
      // Check if already exists for today
      final existing = await db.query(
        'daily_routines',
        where: 'activity = ? AND date = ?',
        whereArgs: [habit.activity, habit.date],
      );
      
      if (existing.isEmpty) {
        await db.insert('daily_routines', habit.toMap());
      }
    }
  }
}
