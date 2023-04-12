import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'homescreen.dart';
import 'main.dart';

Future<Email> createEmail(String email) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/user/create/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Email.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create user.');
  }
}

class Email {
  final int id;
  final String email;

  const Email({required this.id, required this.email});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      email: json['email'],
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

//   Future<http.Response> createUser(String email) {
//   return http.post(
//     Uri.parse('http://localhost:8000/user/create/'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//     }),
//   );
// }

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
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
                      setState(() {
                        _futureEmail = createEmail(_emailcontroller.text);
                      });
                    },
                    child: const Text('Create User'),
                  ),
                      // show a pop-up message
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: const Text('Account Successfully Created!'),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           onPressed: createUser,
                      //           child: const Text('OK'),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
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
