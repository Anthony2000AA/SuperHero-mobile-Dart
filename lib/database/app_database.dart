
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = "hero.database_1";
  final String tableName = "heroes";

  Database? _database;

  Future<Database> openDB() async {
   _database ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        String query  = "CREATE TABLE $tableName(id TEXT PRIMARY KEY, name TEXT, fullName TEXT, path TEXT)";
        db.execute(query);
      },
      version: version
    );
    return _database as Database;
  }
}