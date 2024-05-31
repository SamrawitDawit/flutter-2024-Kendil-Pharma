import 'package:blocint/bloc/signupbloc/signupevent.dart';
import 'package:blocint/bloc/signupbloc/signupstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocint/bloc/signupbloc/sign_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  String _selectedRole = 'Role';

  void updateSelectedRole(String role) {
    _selectedRole = role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            final bool isPharmacist = _selectedRole == 'Pharmacist';
            context.go('/mainpharma', extra: {'token': state.token, 'isPharmacist': isPharmacist});
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets2/front.jpg', // Replace with your own background image path
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
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
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(27, 94, 32, 1),
                                width: 10.0),
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
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(27, 94, 32, 1),
                                width: 10.0),
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
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(27, 94, 32, 1),
                                width: 10.0),
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
                      MyDropdownButtonFormField(
                        controller: _roleController,
                        onRoleChanged: updateSelectedRole,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignupBloc>().add(SignupSubmitted(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: _selectedRole,
                                ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
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
                      SizedBox(height: 20),
                      if (_formKey.currentState != null &&
                          !_formKey.currentState!.validate())
                        Text(
                          'Please fill in all required fields',
                          style: TextStyle(color: Colors.red),
                        ),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: Text(
                          'Already have an account? Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green[900],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


















class MyDropdownButtonFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onRoleChanged;

  MyDropdownButtonFormField(
      {required this.controller, required this.onRoleChanged});

  @override
  _MyDropdownButtonFormFieldState createState() =>
      _MyDropdownButtonFormFieldState();
}

class _MyDropdownButtonFormFieldState extends State<MyDropdownButtonFormField> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole =
        widget.controller.text.isEmpty ? null : widget.controller.text;
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
          borderSide: BorderSide(
              color: const Color.fromRGBO(27, 94, 32, 1), width: 10.0),
        ),
      ),
      items: <String>['Pharmacist', 'Client'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
