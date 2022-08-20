import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_sqlite/blocs/users/users_bloc.dart';
import 'package:simple_sqlite/pages/add_user_page.dart';
import 'package:simple_sqlite/pages/edit_user.dart';

class HomePage extends StatefulWidget {
  static Widget view() => BlocProvider(create: (context) => UsersBloc(), child: const HomePage(),);
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UsersBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<UsersBloc>();
    _bloc.add(const GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List of Users'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) =>
            AddUserPage.view())).then((value) => _bloc.add(const GetUsersEvent())),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if(state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if(state is SuccessState) {
            return RefreshIndicator(
              onRefresh: () async{
                _bloc.add(const GetUsersEvent());
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.users.length,
                itemBuilder: (context, index) => Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.45,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(15),
                        onPressed: (_) => _bloc.add(DeleteUserEvent(state.users[index].id)),
                        backgroundColor: Colors.pink,
                        icon: CupertinoIcons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(15),
                        backgroundColor: Colors.teal,
                        onPressed: (_) => Navigator.push(context, CupertinoPageRoute(builder: (context) => 
                            EditUserPage.view(state.users[index]))).then((value) => _bloc.add(const GetUsersEvent())),
                        icon: CupertinoIcons.pencil,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(state.users[index].name),
                      subtitle: Text('age: ${state.users[index].age}'),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
