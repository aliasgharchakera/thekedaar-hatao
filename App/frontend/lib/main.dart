import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'homescreen.dart';

final logger = Logger();

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _LoginScreen createState() => _LoginScreen();
}

Future<bool> login(username, password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // logger.d("Login successful");
    // return User.fromJson(jsonDecode(response.body));
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    // throw Exception('Failed to login user.');
    return false;
  }
}

class User {
  final String username;
  final String password;

  const User({required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }
}

class _LoginScreen extends State<MyApp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  void _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final user = await login(username, password);
    logger.d(user);
    if (user == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Column(
              children: [
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        logger.d('Forgot password');
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity, // Make button wider
                  child: ElevatedButton(
                    onPressed: _login,
                    // final String username = _usernameController.text;
                    // final String password = _passwordController.text;
                    // // logger.d('Username: $username, Password: $password');
                    // logger.d(login(username, password));
                    // // Navigator.push(
                    // //   context,
                    // //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    // // );
                    // },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.lightBlue, // Set the background color
                      padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 100), // Increase the vertical padding
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20), // Increase the font size
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity, // Make button wider
                  child: ElevatedButton(
                    onPressed: () {
                      logger.d('Sign up');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 91.5),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
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