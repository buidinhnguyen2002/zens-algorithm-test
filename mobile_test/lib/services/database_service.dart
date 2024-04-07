import 'package:mobile_test/database/joke_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const int _version = 1;
  static const String _dbName = 'joke.db';
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, _dbName);
  }

  Future<Database> _initialize() async {
    final dbPath = await fullPath;
    var database = await openDatabase(dbPath,
        version: _version, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async {
    final jokeDB = JokeDB();
    await jokeDB.createTable(database);
    await jokeDB.insertInitData(database);
  }
}
