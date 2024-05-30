import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widget/KendilAppBar.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String _name = '';
  String _password = '';
  String _email = '';
  String _userId = '';

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    setState(() {
      _userId = userId ?? '';
    });
  }

  Future<void> _getUserInfo() async {
    final response = await http.get(Uri.parse('http://localhost:3009/user/$_userId'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _name = jsonData['name'];
        _password = jsonData['password'];
        _email = jsonData['email'];
      });
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(
        title: Text('Profile'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => UserAccountEditPage()),
      //     );
      //   },
      //   child: Icon(Icons.edit, color: Colors.white),
      //   backgroundColor: Colors.green[900],
      // ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              height: 90.0,
              color: Colors.green[900],
            ),
            SizedBox(height: 20.0),
            Text('Name',
              style: TextStyle(
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(_name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text('Age',
              style: TextStyle(
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(_password,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text('Email',
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
                  _email,
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
      ),
    );
  }
}