import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

void signup(fullname, emailaddress, contactnumber, password, confirmpassword) {
  // final url = "dsadasdasdas";
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailaddressController = TextEditingController();
  final TextEditingController _contactnumberController =
      TextEditingController();
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
                controller: _fullnameController,
                decoration: const InputDecoration(
                  hintText: 'Full Name',
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
                controller: _contactnumberController,
                decoration: const InputDecoration(
                  hintText: 'Contact Number',
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
                      final String fullname = _fullnameController.text;
                      final String emailaddress = _emailaddressController.text;
                      final String contactnumber =
                          _contactnumberController.text;
                      final String password = _passwordController.text;
                      final String confirmpassword =
                          _confirmpasswordController.text;
                      signup(fullname, emailaddress, contactnumber, password,
                          confirmpassword);
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
