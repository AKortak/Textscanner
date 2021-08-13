import 'package:flutter/widgets.dart';
import 'package:hrw_textscanner/sqflite/Database.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test/test.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  group('Test class Database', () {
    test('Test Database Initialization', () async {
      //init
      await DB.init();

      //when
      bool result = DB.db.isOpen;

      //then
      expect(result, true);
      await DB.db.close();
    });
  });
}
