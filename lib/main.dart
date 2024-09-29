import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page
// import 'register_page.dart'; // Import the register page

void main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login and Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set the home to the login page
    );
  }
}
