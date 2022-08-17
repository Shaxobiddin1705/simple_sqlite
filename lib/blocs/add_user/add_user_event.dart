part of 'add_user_bloc.dart';

abstract class AddUserEvent extends Equatable {
  const AddUserEvent();
}

class SaveUserEvent extends AddUserEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}
