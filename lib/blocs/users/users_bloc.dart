import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';
import 'package:simple_sqlite/services/database_service.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  List<User> users = [];
  final _database = DatabaseService();
  UsersBloc() : super(UsersInitial()) {
    on<DeleteUserEvent>((event, emit) async{
      await deleteUser(emit, event, event.id);
    });
    on<GetUsersEvent>((event, emit) async{
      await getUsers(emit, event);
    });
  }

  Future<void> getUsers(Emitter<UsersState> emit, UsersEvent event) async{
    emit(const LoadingState());
    EasyLoading.show(status: 'Loading...');
    List<User>? result = await _database.getUsers();
    if(result != null) {
      users = result;
      emit(SuccessState(users: users));
    } else {
      emit(const ErrorState('Please try again'));
    }
    EasyLoading.dismiss();
  }

  Future<void> deleteUser(Emitter<UsersState> emit, UsersEvent event, String id) async{
    EasyLoading.show(status: 'Loading...');
    emit(const LoadingState());

    await _database.deleteUsers(id);

    await getUsers(emit, event);
    emit(SuccessState(users: users));
    EasyLoading.dismiss();
  }
}
