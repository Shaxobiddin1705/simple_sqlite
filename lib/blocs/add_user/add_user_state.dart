part of 'add_user_bloc.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();
}

class AddUserInitial extends AddUserState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AddUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SuccessState extends AddUserState{
  const SuccessState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ErrorState extends AddUserState{
  final String message;

  const ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
