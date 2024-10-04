import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tableName = "Auth";
  final String _Authid = "id";
  final String _AuthEmailColumName = "email";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName(
              $_Authid INTEGER PRIMARY KEY,
              $_AuthEmailColumName TEXT NOT NULL
          )
      ''');
      },
    );
    return database;
  }

  void addUser(String email) async {
    final db = await database;
    await db.insert(
      _tableName,
      {
        _AuthEmailColumName: email,
      },
    );
  }

  Future<bool> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(_tableName);

    if (data.isNotEmpty) {
      String email = data.first[_AuthEmailColumName] as String;
      return email.isNotEmpty;
    } else {
      return false;
    }
  }
}
