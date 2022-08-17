part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadingState extends UsersState{
  const LoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SuccessState extends UsersState{
  final List<User> users;
  const SuccessState({this.users = const[]});

  @override
  List<Object?> get props => [users];
}

class ErrorState extends UsersState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => throw UnimplementedError();
}
