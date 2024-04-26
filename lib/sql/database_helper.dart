// ignore_for_file: unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
    CREATE TABLE IF NOT EXISTS Users (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      password TEXT
    )
  ''');
    });

    return _database;
  }

  Future<int> registerUser(String name, String email, String password) async {
    Database db = await database;
    return await db.rawInsert('''
      INSERT INTO Users(name, email, password) VALUES(?, ?, ?)
    ''', [name, email, password]);
  }

  Future<List<Map<String, dynamic>>> loginUser(
      String name, String email, String password) async {
    Database db = await database;
    return await db.rawQuery(
        '''SELECT * FROM Users WHERE name = ? AND email = ? AND password = ?''',
        [name, email, password]);
  }
}
