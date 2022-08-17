import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/main.dart';
import 'package:simple_sqlite/models/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  List<User> users = [];
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
    final db = await database;

    final List<Map<String, dynamic>> usersMap = await db.query('users');
    users = List.generate(usersMap.length, (index) => User(id: usersMap[index]['id'], name: usersMap[index]['name'], age: usersMap[index]['age']));
    emit(SuccessState(users: users));
  }

  Future<void> deleteUser(Emitter<UsersState> emit, UsersEvent event, String id) async{
    emit(const LoadingState());
    final db = await database;

    await db.delete('users', where: 'id = ?', whereArgs: [id]);
    await getUsers(emit, event);
    emit(SuccessState(users: users));
  }
}
