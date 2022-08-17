part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class GetUsersEvent extends UsersEvent{
  const GetUsersEvent();

  @override
  List<Object?> get props => [];

}

class DeleteUserEvent extends UsersEvent{
  final String id;
  const DeleteUserEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
