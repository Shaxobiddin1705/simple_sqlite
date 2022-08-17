part of 'edit_user_bloc.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();
}

class SaveEditedUserEvent extends EditUserEvent{
  final String id;

  const SaveEditedUserEvent(this.id);

  @override
  List<Object?> get props => [id];
}
