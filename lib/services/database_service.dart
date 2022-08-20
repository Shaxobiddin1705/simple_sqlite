import 'dart:io';

import 'package:path/path.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  DatabaseService._internal();

  final String _databaseName = 'users_database.db';
  final int _databaseVersion = 1;
  final String tableName = 'users';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnAge = 'age';


  static final DatabaseService instance = DatabaseService._internal();
  factory DatabaseService() => instance;
  static Database? _db;

  // _database = openDatabase(join(await getDatabasesPath(), 'users_database.db'),
  // onCreate: (db, version) {
  // return db.execute('CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, age INTEGER)');
  // },
  // version: 1,
  // );

  Future<Database?> get db async => _db ??= await _initDb();

  Future<Database> _initDb() async{
    String path = await getDatabasesPath();
    final usersDb = await openDatabase(join(path, _databaseName), onCreate: _onCreate, version: _databaseVersion);
    return usersDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
      'CREATE TABLE $_databaseName($columnId TEXT PRIMARY KEY, $columnName TEXT, $columnAge INTEGER)'
    );
  }

  Future<List<User>?> getUsers() async{
    final database = await db;

    final List<Map<String, dynamic>>? usersMap = await database?.query(tableName);
    List<User> users;
    if(usersMap != null) {
      users = List.generate(usersMap.length, (index) => User(id: usersMap[index]['id'], name: usersMap[index]['name'], age: usersMap[index]['age']));
      return users;
    }
    return null;
  }

  Future<void> deleteUsers(String id) async{
    final database = await db;

    await database?.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> addUsers(User user) async{
    final database = await db;

    return await database?.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int?> editUser(User user) async{
    final database = await db;

    return await database?.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}