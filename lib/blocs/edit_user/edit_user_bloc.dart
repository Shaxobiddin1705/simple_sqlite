import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:simple_sqlite/services/database_service.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  late String name;
  late int age;
  late BuildContext context;
  EditUserBloc() : super(EditUserInitial()) {
    on<SaveEditedUserEvent>((event, emit) async{
      await editUser(event, emit, event.id);
    });
  }

  Future<void> editUser(EditUserEvent state, Emitter<EditUserState> emit, String id) async {
    final database = DatabaseService();

    final User user = User(id: id, name: name, age: age);
    database.editUser(user).then((value) {
      if(value != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Successfully edited')));
        Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Please try again')));
      }
    });
  }
}
