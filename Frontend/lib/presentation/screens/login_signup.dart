import 'package:newcompiled/presentation/screens/listmedicince.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'mainpharmapage.dart';
import 'welcome.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(LoginPharmacyApp());
}

class LoginPharmacyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Future<void> login(String email, String password) async{
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }
        ),);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201){
        final Map<String, dynamic> data = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        bool role = data['Role'] == 'Pharmacist';
        String id = data['id'];

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPharmaPage(isPharmacist: role, user_id:id)),
        );
      }else{
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text('Invalid email or password.'),
            actions: <Widget>[
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('OK'),)
            ],
          );
        });
      }
    }

    // Future<void> checkLoginStatus() async{
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? authToken = prefs.getString('auth_token');
    //   if (authToken != null){
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPharmaPage(isPharmacist: role,)));
    //   }
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> WelcomePage())); // Navigates back to the previous page
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets2/front.jpg', // Replace with your own background image path
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 100),
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.green), // Set text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(1),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 15, 68, 18), width: 10.0 ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.green), // Set text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(1),
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green, width: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {login(_emailController.text, _passwordController.text);},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
            
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(fontSize: 16, color: Colors.green[900], fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  String _selectedRole  = 'Role';
  void updateSelectedRole(String role) {
    _selectedRole = role;
  }


  @override
  Widget build(BuildContext context) {
    Future<void> signUp(String name, String email, String password, String role) async{
      // if (!_formKey.currentState!.validate()) {
      //   return;
      // }
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }
        ),);
      bool isPharmacist = role == 'Pharmacist';
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201){
        print(response.body);
        String id = data['id'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPharmaPage(isPharmacist: isPharmacist, user_id: id,)),
        );
      }else{
        print(response.body);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> WelcomePage())); // Navigates back to the previous page
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets2/front.jpg', // Replace with your own background image path
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.green), // Set text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(1),
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: const Color.fromRGBO(27, 94, 32, 1), width: 10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.green), // Set text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(1),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: const Color.fromRGBO(27, 94, 32, 1), width: 10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add more complex email validation if needed
                      return null;
                    },
                  ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.green), // Set text color
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(1),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: const Color.fromRGBO(27, 94, 32, 1), width: 10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more complex password validation if needed
                  return null;
                },
              ),

                  SizedBox(height: 20),

                  Form(
                    child: Column(
                      children: [
                        // Other form fields...
                        MyDropdownButtonFormField(
                          controller: _roleController,
                          onRoleChanged: updateSelectedRole,
                        ),
                        // Other form fields...
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signUp(_nameController.text, _emailController.text, _passwordController.text, _selectedRole);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  
                  ),
                  SizedBox(height: 20,),
                  if (_formKey.currentState != null && !_formKey.currentState!.validate())
                    Text(
                      'Please fill in all required fields',
                      style: TextStyle(color: Colors.red),
                    ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(fontSize: 16, color: Colors.green[900], fontWeight: FontWeight.w900),
                      ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class MyDropdownButtonFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onRoleChanged;


  MyDropdownButtonFormField({required this.controller, required this.onRoleChanged});

  @override
  _MyDropdownButtonFormFieldState createState() =>
      _MyDropdownButtonFormFieldState();
}
class _MyDropdownButtonFormFieldState extends State<MyDropdownButtonFormField> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.controller.text.isEmpty ? null : widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedRole = newValue;
          });
          widget.controller.text = newValue; // Update the controller's text
          widget.onRoleChanged(newValue); // Notify the parent about the role change
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(1),
        hintText: 'Role',
        prefixIcon: Icon(Icons.work, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: const Color.fromRGBO(27, 94, 32, 1), width: 10.0),
        ),
      ),
      items: <String>['Pharmacist', 'Client']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
