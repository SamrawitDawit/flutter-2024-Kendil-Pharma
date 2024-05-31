import 'package:blocint/bloc/useracceditbloc/useracceditbloc.dart';
import 'package:blocint/bloc/useracceditbloc/useracceditevent.dart';
import 'package:blocint/bloc/useracceditbloc/useracceditstate.dart';
import 'package:blocint/models/useracceditmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountEditPage2 extends StatefulWidget {
  final String name;
  final String email;

  const UserAccountEditPage2({required this.name, required this.email});

  @override
  _UserAccountEditPage2State createState() => _UserAccountEditPage2State();
}

class _UserAccountEditPage2State extends State<UserAccountEditPage2> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    print("Initial Name: $_name, Initial Email: $_email");
    BlocProvider.of<UserBloc2>(context).add(LoadUserInfo2());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<UserBloc2, UserState2>(
          builder: (context, state) {
            print('Current State: $state'); // Debug statement

            if (state is UserLoading2) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded2) {
              _name = state.user.name;
              _email = state.user.email;
              print("Loaded Name: $_name, Loaded Email: $_email");

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name.isNotEmpty ? _name : widget.name,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value ?? widget.name;
                      },
                    ),
                    TextFormField(
                      initialValue: _email.isNotEmpty ? _email : widget.email,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value ?? widget.email;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            print("Saved Name: $_name, Saved Email: $_email");
                            final user = User2(name: _name, email: _email);
                            BlocProvider.of<UserBloc2>(context).add(UpdateUserInfo2(user));
                          }
                        },
                        child: Text('Save', style: TextStyle(color: Colors.green)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<UserBloc2>(context).add(DeleteUserAccount2());
                        },
                        child: Text('Delete Account', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserError2) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
