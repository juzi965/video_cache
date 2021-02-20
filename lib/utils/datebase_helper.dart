import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String table = 'video_table';
  final String id = 'id';
  final String vid = 'vid';
  final String avatar = 'avatar';
  final String time = 'time';
  final String type = 'type';
  final String nickName = 'nickName';
  final String thumb = 'thumb';
  final String url = 'url';

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();

    return _db;
  }

  Future<Database> init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'favorite.db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE $table(
          $id INTEGER PRIMARY KEY,
          $vid TEXT,
          $avatar TEXT,
          $time TEXT,
          $type TEXT,
          $nickName TEXT,
          $thumb TEXT,
          $url TEXT)''');
  }
}
