import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'homescreen.dart';
import 'main.dart';

final logger = Logger();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

// void signup(fullname, emailaddress, contactnumber, password, confirmpassword) {
//   // final url = "dsadasdasdas";
// }
Future<String> signup(username, password, email, first_name, last_name) async {
  final response = await http.post(
    Uri.parse('$URL/signup/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return "User created successfully";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return "Failed to create user";
  }
}

class User {
  final int id;
  final String email;

  const User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
    );
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailaddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailaddressController,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                controller: _confirmpasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: SizedBox(
                  // width: 91.5,
                  // height: 12.0,
                  child: ElevatedButton(
                    onPressed: () {
                      final String username = _usernameController.text;
                      final String emailaddress = _emailaddressController.text;
                      final String firstname = _firstnameController.text;
                      final String lastname = _lastnameController.text;
                      final String password = _passwordController.text;
                      final String confirmpassword =
                          _confirmpasswordController.text;
                      signup(username, password, emailaddress, firstname,
                          lastname);
                      // show a pop-up message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Account Successfully Created!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Create Account'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
