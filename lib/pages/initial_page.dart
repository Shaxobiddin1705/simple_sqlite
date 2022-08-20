import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_sqlite/blocs/network/network_bloc.dart';
import 'package:simple_sqlite/pages/home_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    context.read<NetworkBloc>().subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        context.read<NetworkBloc>().add(const OnConnectedEvent());
      } else {
        context.read<NetworkBloc>().add(const OnNotConnectedEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if(state is ConnectedFailureState) {
          return const Scaffold(
            body: Center(
              child: Text('No connection'),
            ),
          );
        }
        if(state is ConnectedSuccessState) {
          return HomePage.view();
        }
        return Container();
      }
    );
  }
}
