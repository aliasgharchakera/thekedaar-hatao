import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SellItemScreen extends StatefulWidget {
  final String authToken;
  const SellItemScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  State<SellItemScreen> createState() => SellItemScreenState();
}

class SellItemScreenState extends State<SellItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String material = '';
  String quantity = '';
  String price = '';
  String dropdownValue = 'Metal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: const Text('Add Item')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32.0),
                  DropdownButton<String>(
                    value: dropdownValue, // Added this line to specify value
                    onChanged: (String? newValue) {
                      setState(() {
                        // if (newValue == null ||
                        //     newValue.isEmpty ||
                        //     newValue == 'Select Material') {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text('Please select a material'),
                        //     ),
                        //   );
                        //   return;
                        // }
                        dropdownValue = newValue!;
                        material =
                            newValue; // Added this line to update material value
                      });
                    },
                    items: <String>['Metal', 'Sand', 'Brick', 'Cement']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Price',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      price = value!;
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Quantity',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      quantity = value!;
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: SizedBox(
                      // width: 91.5,
                      // height: 12.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final response = await http.post(
                              Uri.parse(
                                  'http://127.0.0.1:8000/marketplace/create/'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Authorization': 'Token $authToken',
                              },
                              body: jsonEncode(<String, String>{
                                'material': material,
                                'quantity': quantity,
                                'price': price,
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
                        child: const Text('Add item'),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
