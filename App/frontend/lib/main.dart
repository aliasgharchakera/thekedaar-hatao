import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'homescreen.dart';

final logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  Future<http.Response> buttonPressed() async {
    http.Response returnedResult = await http.get(
      Uri.parse('http://localhost:8000/hello/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
      });
      print(returnedResult.body);
      return returnedResult;
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
                    onPressed: () {
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;
                      logger.d('Username: $username, Password: $password');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomeScreen()),
                      // );
                    },
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
                          builder: (context) => const SignUpScreen(),
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
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity, // Make button wider
                  child: ElevatedButton(
                    onPressed: buttonPressed,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20), // Increase the font size
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


// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import '2signup.dart';

// final logger = Logger();

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   static final navigatorKey = GlobalKey<NavigatorState>();

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Login',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//                 labelStyle: TextStyle(color: Colors.white),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Colors.white),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             Column(
//               children: [
//                 const SizedBox(height: 2),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         logger.d('Forgot password');
//                       },
//                       child: const Text('Forgot password?'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 SizedBox(
//                   width: double.infinity, // Make button wider
//                   child: ElevatedButton(
//                     onPressed: () {
//                       final String username = _usernameController.text;
//                       final String password = _passwordController.text;
//                       logger.d('Username: $username, Password: $password');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           Colors.lightBlue, // Set the background color
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 100), // Increase the vertical padding
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(fontSize: 20), // Increase the font size
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 SizedBox(
//                   width: double.infinity, // Make button wider
//                   child: ElevatedButton(
//                     onPressed: () {
//                       logger.d('Sign up');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SignUpScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 91.5),
//                     ),
//                     child: const Text(
//                       'Sign up',
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // class SignUpScreen extends StatelessWidget {
// //   const SignUpScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.orange,
// //       appBar: AppBar(title: const Text('Sign Up')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 20),
// //             const Text(
// //               'SIGN UP',
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 20),
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Username',
// //                 labelStyle: TextStyle(color: Colors.white),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Email Address',
// //                 labelStyle: TextStyle(color: Colors.white),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Password',
// //                 labelStyle: TextStyle(color: Colors.white),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Confirm Password',
// //                 labelStyle: TextStyle(color: Colors.white),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Contact Number',
// //                 labelStyle: TextStyle(color: Colors.white),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Row(
// //               children: [
// //                 Checkbox(value: false, onChanged: (bool? value) {}),
// //                 const Text(
// //                   'I have read and agreed to the terms and conditions',
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 40),
// //             Center(
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   logger.d('Sign up');
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.lightBlue,
// //                   padding: const EdgeInsets.symmetric(
// //                       vertical: 12, horizontal: 91.5),
// //                 ),
// //                 child: const Text(
// //                   'Create Account',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
