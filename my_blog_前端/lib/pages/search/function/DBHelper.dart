import 'package:my_blog/model/SearchHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as PathUtils;

import '../../../model/Constant.dart';
/*
* 操作数据库的类
* */
class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper _instance = DBHelper._privateConstructor();
  static DBHelper get instance => _instance;
  factory DBHelper() {
    return _instance;
  }
  late Database _db;
  Future<Database> get db async {
    // if(null == _db) _db = await _initDb();
    _db = await _initDb();
    return _db;
  }
  _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = PathUtils.join(databasesPath, Constant.dbName);
    return await openDatabase(
      path,
      version: Constant.dbVersion,
      onCreate: _onCreate,
    );
  }
  void _onCreate(Database db, int version) =>
      db.execute('create table ${Constant.searchHistoryTable}'
      '("id" integer primary key autoincrement,'
      ' "keyword" text unique, "time" integer)');
  void close() async {
    if(_db != null) await _db.close();
  }
  Future<SearchHistory> insert(SearchHistory searchHistory) async {
    var _db = await db;
    try {
      searchHistory.id =
          await _db.insert(Constant.searchHistoryTable, searchHistory.toMap(searchHistory));
    } catch (e) {
    }
    return searchHistory;
  }
  Future<SearchHistory?> query(int id) async {
    var __db = await db;
    var maps = await __db
      .query(Constant.searchHistoryTable, where: 'id = ?', whereArgs: [id]);
    if(maps.length > 0) {
      return SearchHistory.fromMap(maps.first);
    }
    return null;
  }
  Future<List<SearchHistory>> search(String key) async {
    var _db = await db;
    var maps = await _db.query(Constant.searchHistoryTable,
    where: 'keyword like %?%', whereArgs: [key]);
    var list = <SearchHistory>[];
    maps.forEach((value) {
      list.add(SearchHistory.fromMap(value));
    });
    return list;
  }
  Future<List<SearchHistory>> queryAll() async {
    var __db = await db;
    var maps = await __db.query(Constant.searchHistoryTable);
    var list = <SearchHistory>[];
    maps.forEach((value) {
      list.add(SearchHistory.fromMap(value));
    });
    return list;
  }
  Future<int> deleteAll() async {
    var _db = await db;
    return await _db.delete(Constant.searchHistoryTable);
  }
  Future<int> delete(int? id) async {
    var _db = await db;
    return await _db
        .delete(Constant.searchHistoryTable, where: 'id = ?', whereArgs: [id]);
  }
}