part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();
}

class ConnectedInitialState extends NetworkState {
  const ConnectedInitialState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ConnectedSuccessState extends NetworkState {
  const ConnectedSuccessState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ConnectedFailureState extends NetworkState {
  const ConnectedFailureState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}