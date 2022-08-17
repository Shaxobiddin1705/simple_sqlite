import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:uuid/uuid.dart';

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
    final db = await database;

    final User user = User(id: id, name: name, age: age);
    db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( 'Successfully edited')));
      Navigator.pop(context);
    });
  }
}
