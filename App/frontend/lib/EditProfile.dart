import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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
        Uri.parse('http://127.0.0.1:8000/user/'),
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
        Uri.parse('http://127.0.0.1:8000/user/'),
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
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/user/update_password/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ${widget.authToken}',
        },
        body: jsonEncode(<String, String>{
          'old_password': _oldPasswordController.text,
          'new_password': _newPasswordController.text,
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
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
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
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password again',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO: implement update profile logic
                    _updateUser();
                    _updatePassword();
                  }
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
