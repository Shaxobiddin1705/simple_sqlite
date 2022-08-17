import 'package:flutter/material.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Store Users in Sqlite'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please fill the field";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter id',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70
                    ),
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please fill the field";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter age',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70
                    ),
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please fill the field";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter name',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70
                    ),
                  ),

                  const SizedBox(height: 20,),

                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.7,
                    height: 48,
                    color: Colors.teal,
                    onPressed: () async{
                      if(_formKey.currentState!.validate()) {
                        await insertUser();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Please fill all the fields')));
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Text('Save to Sqlite'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> insertUser() async{
    final db = await database;

    User user = User(
        id: int.parse(_idController.text.trim()),
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()));
    db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      if(value != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Successfully saved')));
        Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Something went wrong, please try again')));
      }
    });
    setState(() {});
  }

}
