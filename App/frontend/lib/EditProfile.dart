import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'main.dart';
import 'Drawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final String authToken;
  const EditProfileScreen({Key? key, required this.authToken})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$URL/user/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _firstNameController.text = json['first_name'];
        _lastNameController.text = json['last_name'];
        _emailController.text = json['email'];
      } else {
        setState(() {
          _errorMessage = 'Failed to load user';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  Future<void> _updateUser() async {
    try {
      final response = await http.put(
        Uri.parse('$URL/user/update/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ${widget.authToken}',
        },
        body: jsonEncode(<String, String>{
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'email': _emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          _errorMessage = 'Failed to update user';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  Future<void> _updatePassword() async {
    String? newPassword;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  hintText: 'Old Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                onChanged: (value) => newPassword = value,
                decoration: InputDecoration(
                  hintText: 'New Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm New Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value != newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final response = await http.put(
                      Uri.parse('$URL/user/update_password/'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization': 'Token ${widget.authToken}',
                      },
                      body: jsonEncode(<String, String>{
                        'old_password': _oldPasswordController.text,
                        'new_password': newPassword!,
                      }),
                    );

                    if (response.statusCode == 200) {
                      Navigator.pop(context, true);
                    } else {
                      setState(() {
                        _errorMessage = json.decode(response.body)['message'];
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'An error occurred: $e';
                    });
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              // Text(
              //   'Email',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: _updatePassword,
                  child: const Text('Change Password')),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO: implement update profile logic
                    _updateUser();
                  }
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
