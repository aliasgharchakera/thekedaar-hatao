import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'main.dart';

class SellItemScreen extends StatefulWidget {
  const SellItemScreen({Key? key}) : super(key: key);

  @override
  State<SellItemScreen> createState() => SellItemScreenState();
}

class SellItemScreenState extends State<SellItemScreen> {
  String name = '';
  String description = '';
  String price = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: const Text('Add Item')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Item Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Description',
                  fillColor: Colors.white,
                  filled: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Price',
                  fillColor: Colors.white,
                  filled: true,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: SizedBox(
                  // width: 91.5,
                  // height: 12.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // show a pop-up message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Item Successfully added!'),
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
                    child: const Text('Add item'),
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