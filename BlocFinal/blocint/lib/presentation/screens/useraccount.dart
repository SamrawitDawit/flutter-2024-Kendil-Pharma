import 'package:blocint/bloc/useraccountviewbloc/useraccbloc.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccevent.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/KendilAppBar.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  late UserBloc _userBloc; // Declare UserBloc variable
  late bool isPharmacist;
  late String token;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context); // Initialize UserBloc
    _loadUserIdAndFetchInfo();
  }

  Future<void> _loadUserIdAndFetchInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';
    _userBloc.add(LoadUserInfo(userId)); // Use _userBloc to add event
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: KendilAppBar(
        title: Text('Profile'),
        onBackButtonPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          isPharmacist = prefs.getBool('isPharmacist') ?? false;
          token = prefs.getString('token') ?? '';
          context.go('/mainpharma', extra: {'token': token, 'isPharmacist': isPharmacist});
        },
      ),
      floatingActionButton: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            // print(state.user.name);
            return FloatingActionButton(
              onPressed: () {
                  context.push('/useraccount/edit', extra: {
                  'name': state.user.name,
                  'email': state.user.email,
                });
              },
              child: Icon(Icons.edit, color: Colors.white),
              backgroundColor: Colors.green[900],
            );
          }
          return Container(); // Return an empty container if state is not UserLoaded
        },
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial || state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Padding(
              padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: 90.0,
                    color: Colors.green[900],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Name',
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    state.user.name,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Role',
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    state.user.role,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Email',
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.green[900],
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        state.user.email,
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text('Failed to load user info'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
