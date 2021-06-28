import 'package:hrw_textscanner/sqflite/Database.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test/test.dart';

class MockReturnDB extends Mock implements Future<Database> {}

class MockDatabase extends Mock implements Database {}

class MockSqlfite extends Mock implements Sqflite {}

class DBForTest extends DB {}

class MockDBForTest extends Mock implements DBForTest {}

void main(List<String> args) {
  Database database = MockDatabase();
//  MockReturnDB returnedDB = MockReturnDB();
  DBForTest db = DBForTest();
//  MockDBForTest mockDB = MockDBForTest();

  test('Test Database Initialisation', () async {
    when(openDatabase(any)).thenAnswer((_) => database as Future<Database>);
    // DB.init();
    expect(database.isOpen, true);
  });
}
