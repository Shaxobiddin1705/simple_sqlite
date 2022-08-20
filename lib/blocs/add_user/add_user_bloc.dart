import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/blocs/users/users_bloc.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:simple_sqlite/services/database_service.dart';
import 'package:uuid/uuid.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  late String name;
  late int age;
  late BuildContext context;
  final _database = DatabaseService();
  AddUserBloc() : super(AddUserInitial()) {
    on<SaveUserEvent>((event, emit) async{
      await insertUser(emit, event);
    });
  }

  Future<void> insertUser(Emitter<AddUserState> emit, AddUserEvent event) async{
    final String id = const Uuid().v1();
    User user = User(id: id, name: name, age: age);

    _database.addUsers(user).then((value){
      if(value != 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully saved')));
        Navigator.pop(context);
      }else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please try again')));
      }
    });
  }
}
