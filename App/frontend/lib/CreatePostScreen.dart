// import 'package:flutter/material.dart';
// import './main.dart';
// import 'dart:convert';
// import 'Drawer.dart';
// import 'package:http/http.dart' as http;

// class CreatePostScreen extends StatefulWidget {
//   final String authToken;

//   const CreatePostScreen({Key? key, required this.authToken}) : super(key: key);

//   @override
//   _CreatePostScreenState createState() => _CreatePostScreenState();
// }

// class _CreatePostScreenState extends State<CreatePostScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   String _content = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create a new post'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _title = value!;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Content',
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some content';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _content = value!;
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     final response = await http.post(
//                       Uri.parse('$URL/forum/create/'),
//                       headers: <String, String>{
//                         'Content-Type': 'application/json; charset=UTF-8',
//                         'Authorization': 'Token $authToken',
//                       },
//                       body: jsonEncode(<String, String>{
//                         'title': _title,
//                         'content': _content,
//                       }),
//                     );
//                     if (response.statusCode == 201) {
//                       Navigator.pop(context, true);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Failed to create post'),
//                         ),
//                       );
//                     }
//                   }
//                 },
//                 child: const Text('Create'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       drawer: const CustomDrawer(),
//     );
//   }
// }

//Here changes

import 'package:flutter/material.dart';
import './Calculator.dart';
import './Marketplace.dart';
import 'homescreen.dart';
import './main.dart';
import 'Drawer.dart';
import 'Profile.dart';
import 'HelpCenter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreatePostScreen extends StatefulWidget {
  final String authToken;

  const CreatePostScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Create a new post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final response = await http.post(
                      Uri.parse('$URL/forum/create/'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization': 'Token $authToken',
                      },
                      body: jsonEncode(<String, String>{
                        'title': _title,
                        'content': _content,
                      }),
                    );
                    if (response.statusCode == 201) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Failed to create post'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
