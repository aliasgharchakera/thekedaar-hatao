import 'package:flutter/material.dart';
import 'Forum.dart';

class AddNewPostScreen extends StatefulWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  _AddNewPostScreenState createState() => _AddNewPostScreenState();
}

class _AddNewPostScreenState extends State<AddNewPostScreen> {
  String _title = '';
  String _description = '';

  void _onTitleChanged(String newValue) {
    setState(() {
      _title = newValue;
    });
  }

  void _onDescriptionChanged(String newValue) {
    setState(() {
      _description = newValue;
    });
  }

  void _onPostButtonPressed() {
    // Implement your post button functionality here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForumScreen(),
      ),
    );
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(),
              // isDense: true,
            ),
            onChanged: _onTitleChanged,
            maxLines: 8,
            minLines: 1,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Description',
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(),
              // isDense: true,
            ),
            onChanged: _onDescriptionChanged,
            maxLines: 8,
            minLines: 1,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _onPostButtonPressed,
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}