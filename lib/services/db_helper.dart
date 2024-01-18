import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart  ';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const dbName = "data.db";
  static const dbVersion = 1;
  static const dbTable = "profile_info";
  static const dtId = "id";
  static const dtName = "name";
  static const dtDesc = "desc";

  static final DbHelper instance = DbHelper();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $dbTable(
      $dtId INTEGER PRIMARY KEY,
      $dtName TEXT NOT NULL,
      $dtDesc TEXT NOT NULL
    )
  ''');
  }

// insertRecord
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

// read/query records
  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

//update record
  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[dtId];
    return await db!.update(dbTable, row, where: '$dtId=?', whereArgs: [id]);
  }

// delete records
  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$dtId=?', whereArgs: [id]);
  }
}
