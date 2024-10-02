import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS items(
        email TEXT,
        password TEXT,
        phone TEXT,
        category TEXT,
        isloged INTEGER DEFAULT 0
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(join(await sql.getDatabasesPath(), 'hi.db'),
        version: 1, onCreate: (sql.Database database, int version) async {
      //'....Creating a table....'
      await createTables(database);
    });
  }

  static Future<void> createItem(String emailtext, String? passwordtext,
      String? phonetext, String? categorytext) async {
    final db = await SqlHelper.db();
    final data = {
      'email': emailtext,
      'password': passwordtext,
      'phone': phonetext,
      'category': categorytext
    };
    await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqlHelper.db();
    return db.query('items');
  }
}
