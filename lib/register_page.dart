import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {



  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});
  Future<void> registerUser(Map<String, dynamic> user) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        'http://192.168.8.146:3000/user',
        data: user,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      // You can handle the response here
      print('Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
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
            ElevatedButton(
              onPressed: () {
                // Add your registration logic here
                String name = nameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                print('Name: $name, Email: $email, Password: $password');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
