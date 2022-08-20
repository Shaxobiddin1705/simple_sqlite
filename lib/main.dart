import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';
import 'package:simple_sqlite/blocs/network/network_bloc.dart';
import 'package:simple_sqlite/pages/home_page.dart';
import 'package:simple_sqlite/pages/initial_page.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> database;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NetworkBloc()..add(const OnNotConnectedEvent()),
      child: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if(state is ConnectedFailureState) {
            return context.read<NetworkBloc>().add(OnNotConnectedEvent());
          }
        },
          builder: (context, state) {
            if(state is ConnectedFailureState) {
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const Scaffold(
                  body: Center(
                    child: Text('No connection'),
                  ),
                ),
              );
            }
            if(state is ConnectedSuccessState) {
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: HomePage.view(),
                builder: EasyLoading.init(),
              );
            }
            return Container();
        }
      )
    );
  }
}