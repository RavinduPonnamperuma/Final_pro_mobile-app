import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'register_page.dart'; // Import the register page for navigation
import 'dashbord.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

    Future<void> loginUser(BuildContext context, String email, String password) async {
    Dio dio = Dio();
     String email = emailController.text;
     String password = passwordController.text;

  // Log the email and password being sent
     print('Email: $email, Password: $password');


    try {
      Response response = await dio.post(
        'http://192.168.43.75:3000/user/login', // Replace with your API URL
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Handle successful login, navigate to the Dashboard
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      }
    } catch (e) {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your login logic here
                //     Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DashboardPage()),
                // );
                //     String email = emailController.text;
                //     String password = passwordController.text;
                //     print('Email: $email, Password: $password');
                //   },
                //   child: const Text('Login'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    loginUser(context, email, password);
                    
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear the text fields
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // Navigate to the RegisterPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              
              child: const Text('Register Now'),
            ),
          ],
        ),
      ),
    );
  }
}
