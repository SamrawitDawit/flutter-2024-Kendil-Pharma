import 'package:flutter/material.dart';
import '../widget/KendilAppBar.dart';
import 'useraccountedit.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: UserAccount(),
//   ));
// }
class UserAccount extends StatefulWidget {
  final String user_id;
  const UserAccount({Key? key, required this.user_id});

  @override
  State<UserAccount> createState() => _UserAccount();
}

class _UserAccount extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[850],
      appBar: KendilAppBar(
        title: Text('Profile'),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> UserAccountEditPage() ));
          },
          child: Icon(Icons.edit, color: Colors.white,),
          backgroundColor: Colors.green[900],
        ),
        body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Divider(
                height: 90.0,
                  color: Colors.green[900],
              ),
              SizedBox(height: 20.0,),
              Text('Name',
              style: TextStyle(
                // color: Colors.white,
                letterSpacing: 2.0,
                )
              ),
              SizedBox(height: 10.0,),
              Text('Samrawit',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    letterSpacing: 2.0,
                  )
              ),
              SizedBox(height: 20.0,),
              Text('Age',
                  style: TextStyle(
                    // color: Colors.white,
                    letterSpacing: 2.0,
                  )
              ),
              SizedBox(height: 10.0,),
                Text('20',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                      letterSpacing: 2.0,
                    ),
                ),
              SizedBox(height: 20.0,),
              Text('Email',
                  style: TextStyle(
                    // color: Colors.white,
                    letterSpacing: 2.0,
                  )
              ),
              SizedBox(height: 10.0,),
            Row(
              children: <Widget> [
                Icon(
                  Icons.email,
                  color: Colors.green[900],
                ),
                SizedBox(width: 10.0),
                Text(
                  'samrikdawit@gmail.com',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]
            ), 
            ],

          )
          )
        );

  }
}



