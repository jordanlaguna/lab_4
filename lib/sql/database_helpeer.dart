import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  late final Database _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  Future<Database> get database async {
    return await initDatabase();
  }

  Future<Database> initDatabase() async {
  
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'demo3.db');
    //print("aqui");
    _database = await openDatabase(path, version: 2,
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
    final Database db = await database;
    return await db.rawInsert('''
      INSERT INTO Users(name, email, password) VALUES(?, ?, ?)
    ''', [name, email, password]);
  }

  Future<List<Map<String, dynamic>>> loginUser(
      String email, String password) async {
    final Database db = await database;
    return await db.rawQuery('''
      SELECT * FROM Users WHERE email = ? AND password = ?
    ''', [email, password]);
  }
}
