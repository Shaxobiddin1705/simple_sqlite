import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/blocs/users/users_bloc.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  late String name;
  late int age;
  late BuildContext context;
  AddUserBloc() : super(AddUserInitial()) {
    on<AddUserEvent>((event, emit) async{
      await insertUser(emit, event);
    });
  }

  Future<void> insertUser(Emitter<AddUserState> emit, AddUserEvent event) async{
    final db = await database;
    final String id = const Uuid().v1();
    User user = User(id: id, name: name, age: age);
    db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Successfully saved')));
      Navigator.pop(context);
    });
  }
}
