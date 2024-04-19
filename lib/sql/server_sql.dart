// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'demo.db');

  // Abrir la base de datos
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // Al crear la base de datos, crear la tabla
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  });

  // Insertar algunos registros en una transacción
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES("Tony", 1234, 456.789)');
    print('inserted1: $id1');
    int id2 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
        ['gatoman', 12345678, 3.1416]);
    print('inserted2: $id2');
  });

  // Obtener los registros
  List<Map<String, dynamic>> list =
      await database.rawQuery('SELECT * FROM Test');
  List<Map<String, dynamic>> expectedList = [
    {'name': 'Tony', 'id': 1, 'value': 9876, 'num': 456.789},
    {'name': 'gatoman', 'id': 2, 'value': 12345678, 'num': 3.1416}
  ];
  print(list);
  print(expectedList);
  assert(list.toString() == expectedList.toString());

  // Cerrar la base de datos
  await database.close();
}
