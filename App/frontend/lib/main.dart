import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'homescreen.dart';

final logger = Logger();
const URL = 'https://thekedaar-hatao-thekedaar-hatao-36034846.koyeb.app';
// const URL = 'http://127.0.0.1:8000/';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _LoginScreen createState() => _LoginScreen();
}

String authToken = '';
Future<bool> login(username, password) async {
  final response = await http.post(
    Uri.parse('$URL/login/'),
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

Future<bool> auth(username, password) async {
  final response = await http.post(
    Uri.parse('$URL/api-token-auth/'),
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
    authToken = jsonDecode(response.body)['token'];
    // logger.d(authToken);
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
    await auth(username, password);
    // logger.d(user);
    if (user == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  authToken: authToken,
                )),
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 50,
        centerTitle: true,
        elevation: 0,
        title: const Text('Welcome to Thekedaar Hatao',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'times-new-roman'
                ),
              ),
      ),
      body: SingleChildScrollView(child: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Image.asset('assets/images/logo.png',
            height: 200,),
            const Align(
              alignment:Alignment.centerLeft,
              child: Text(
              'Login',
              style: TextStyle(
                // height: 1,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily:'Roboto',
                
              ),
            ),
            ),

            const Align(
              alignment:Alignment.centerLeft,
              child: Text(
              'Please sign in to continue.',
              style: TextStyle(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 3,
              ),
            ),
            ),
          
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.blue),
                // contentPadding:  EdgeInsets.all,
                // border: OutlineInputBorder(),
              ),
              // textAlignVertical: TextAlignVertical.center,
              // textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blue),
                // border: OutlineInputBorder(),
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
                const SizedBox(height: 16),
                Align(
                  alignment:Alignment.centerRight,
                  child:
                SizedBox(
                  width: 120, //double.infinity, // Make button wider
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.lightBlue, // Set the background color
                      padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70),),
                          
                    ),
                    child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:const [ Text('Login',style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward),]
                    ),
                  ),
                ),
                ),
                Container(
                  height: 30,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 2,),
                child: GestureDetector(
                  onTap: () {
                    // logger.d('Sign up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                ),
                Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 2),
                child: GestureDetector(
                  onTap: () {
                    // logger.d('Sign up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            authToken: authToken,
                          ),
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t want to Sign Up? Enter as guest',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}
