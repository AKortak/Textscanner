import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;
  static int _version = 1;
  static String scanHistory = "ScanHistory";

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "TestDatabase";
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $scanHistory (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, textAsString STRING, date INTEGER)');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    return _db.query(table);
  }

  static insert(String table, Map data) async {
    await _db.insert(table, data);
  }

  static Future<int> delete(String table, int id) async {
    return await _db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
