import 'package:path/path.dart';
import 'package:salman_project_app/db/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();
  static Database? _database;

  Future<bool> registerUser(UserModelSQL user) async {
    if (_database != null) return true;
    _database = await _initDB();
    return true;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ppkdju.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          email TEXT UNIQUE, 
          password TEXT
          )
          ''');
      },
    );
  }
}
