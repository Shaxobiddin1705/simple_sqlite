import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:simple_sqlite/blocs/edit_user/edit_user_bloc.dart';
import 'package:simple_sqlite/models/user_model.dart';

class EditUserPage extends StatefulWidget {
  static Widget view(User user) => BlocProvider(create: (context) => EditUserBloc(), child: EditUserPage(user: user,),);
  final User? user;
  const EditUserPage({Key? key, this.user}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditUserBloc>();
    bloc.context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update User'),
      ),
      body: BlocBuilder<EditUserBloc, EditUserState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: widget.user!.name,
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
                        initialValue: widget.user!.age.toString(),
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
                            bloc.add(SaveEditedUserEvent(widget.user!.id));
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
          );
        },
      ),
    );
  }
}
