import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseModule {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'coffeemania_db.db'),
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE cart (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_product INTEGER,
          name TEXT,
          image TEXT,
          price TEXT,
          category TEXT
        )
      ''');
      },
      version: 2,
    );
  }
}
