part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();
}

class OnConnectedEvent extends NetworkEvent{
  const OnConnectedEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OnNotConnectedEvent extends NetworkEvent{
  const OnNotConnectedEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}