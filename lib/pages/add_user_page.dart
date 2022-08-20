import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/blocs/add_user/add_user_bloc.dart';

class AddUserPage extends StatefulWidget {
  static Widget view() => BlocProvider(create: (context) => AddUserBloc(), child: const AddUserPage(),);
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddUserBloc>();
    bloc.context = context;
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
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
                        onChanged: (value) {
                          bloc.name = value;
                        },
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

                      TextFormField(
                        onChanged: (value) {
                          bloc.age = int.parse(value);
                        },
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

                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        height: 48,
                        color: Colors.teal,
                        onPressed: () async{
                          if(_formKey.currentState!.validate()) {
                            bloc.add(SaveUserEvent());
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
    );
  }

}
