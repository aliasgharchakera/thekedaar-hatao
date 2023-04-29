import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'homescreen.dart';

final logger = Logger();
const URL = 'https://aliasgharchakera.pythonanywhere.com/';
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
    logger.d(authToken);
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
    logger.d(user);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Thekedaar Hatao',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'times-new-roman'
              ),
            ),
            Align(
              alignment:Alignment.centerLeft,
              child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily:'Roboto',
                
              ),
            ),
            ),

            Align(
              alignment:Alignment.centerLeft,
              child: const Text(
              'Please sign in to continue.',
              style: TextStyle(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 160, 205),
                
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
                    children: [Text('Login',style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward),]
                    // child: const Text(
                    //   'Login',
                    //   style: TextStyle(fontSize: 20,), // Increase the font size
                    // ),
                  ),
                  ),
                ),),


                // const Text('Don\'t have an account?',
                //     style: TextStyle(fontSize: 20, color: Colors.white,height: 2)),
                // const Text('Signup! It won\'t even take a minute!',
                //     style: TextStyle(fontSize: 15, color: Colors.white)),
                // const SizedBox(height: 6),
                // SizedBox(
                //   width: 120,//double.infinity, // Make button wider
                //   child: ElevatedButton(
                //     onPressed: () {
                //       logger.d('Sign up');
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => SignUpScreen(),
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.lightBlue,
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 12, horizontal: 10),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50),)
                //     ),
                //     child: const Text(
                //       'Sign Up',
                //       style: TextStyle(
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 2),
                child: GestureDetector(
                  onTap: () {
                    logger.d('Sign up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue,
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
                    logger.d('Sign up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            authToken: authToken,
                          ),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t want to Sign Up? Enter as guest',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                ),
                // const Text(height:30),
                // const Text('Don\'t want to signup?',
                //     style: TextStyle(fontSize: 20, color: Colors.white,height: 2)),
                // const Text('We got you covered!',
                //     style: TextStyle(fontSize: 15, color: Colors.white)),
                // const SizedBox(height: 5),
                // SizedBox(
                //   width: 200, // Make button wider
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // logger.d('Sign up');
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => HomeScreen(
                //             authToken: authToken,
                //           ),
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.lightBlue,
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 12, horizontal: 10),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50),),
                //     ),
                //     child: const Text(
                //       'Continue as guest',
                //       style: TextStyle(
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
