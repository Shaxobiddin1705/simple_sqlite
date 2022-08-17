import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simple_sqlite/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';

late var database;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(join(await getDatabasesPath(), 'users_database.db'),
    onCreate: (db, version) {
    return db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    },
    version: 1,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}