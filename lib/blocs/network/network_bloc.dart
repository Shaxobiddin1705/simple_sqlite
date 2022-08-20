import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/services/network_helper.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late StreamSubscription<ConnectivityResult> subscription;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  NetworkBloc() : super(const ConnectedInitialState()) {
    on<OnConnectedEvent>((event, emit) => emit(const ConnectedSuccessState()));
    on<OnNotConnectedEvent>((event, emit) => emit(const ConnectedFailureState()));

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        add(const OnConnectedEvent());
      } else {
        add(const OnNotConnectedEvent());
      }
    });
  }

}
