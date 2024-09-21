import 'package:flutter/material.dart';
import 'register_page.dart'; // Import the register page for navigation
import 'dashbord.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

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
                ElevatedButton(
                  onPressed: () {
                    // Add your login logic here
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
                    String email = emailController.text;
                    String password = passwordController.text;
                    print('Email: $email, Password: $password');
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
