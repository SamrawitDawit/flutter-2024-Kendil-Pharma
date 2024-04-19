import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/front.jpg', // Replace with your own background image path
            fit: BoxFit.cover,
          ),
          Padding(
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
                  onPressed: () {},
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
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/front.jpg',             
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
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
                ),
                SizedBox(height: 20),
                TextField(
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
                ),
                SizedBox(height: 20),
                TextField(
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
                ),
                SizedBox(height: 20),
                 TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.green), // Set text color
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
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
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
        ],
      ),
    );
  }
}