import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:simple_sqlite/pages/add_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List of Users'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddUserPage())),
      ),
      body: RefreshIndicator(
        onRefresh: () => getUsers(),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(users[index].name),
              subtitle: Text('age: ${users[index].age}'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUsers() async{
    final db = await database;

    final List<Map<String, dynamic>> usersMap = await db.query('users');

    users = List.generate(usersMap.length, (index) => User(id: usersMap[index]['id'], name: usersMap[index]['name'], age: usersMap[index]['age']));
    setState(() {});
  }
}
