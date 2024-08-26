import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'db_user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
      },
    );
  }

  // Insert Data
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get Data
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }


}