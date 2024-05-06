
import 'package:flutter/material.dart';
import 'package:newcompiled/presentation/screens/login_signup.dart';
import 'package:newcompiled/presentation/screens/mainpharmapage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'create_or_edit_order.dart';
// import 'listmedicince.dart';


import 'screens/welcome.dart';
// import 'order_list.dart';
void main() {
  runApp(KendilPharmaApp());
}

class KendilPharmaApp extends StatelessWidget {
  const KendilPharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // checkLoginStatus(context);

    return MaterialApp(
      home: WelcomePage(),
      // routes: {
      //   '/main_pharma_page': (context) => MainPharmaPage(),
      //
      // },
    );
  }
//   Future<void> checkLoginStatus(BuildContext context) async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? authToken = prefs.getString('auth_token');
//     if (authToken != null){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPharmaPage()));
//     }
//   }
}

