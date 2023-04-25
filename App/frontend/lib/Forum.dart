import 'package:flutter/material.dart';
import './AddNewPost.dart';
import './Calculator.dart';
import './Marketplace.dart';
import 'homescreen.dart';
import './Calculator.dart';
import './main.dart';
import 'Profile.dart';
import 'HelpCenter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForumScreen extends StatefulWidget {
  final String authToken;
  const ForumScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _ForumScreen createState() => _ForumScreen();
}

Future<Forum> getForumAll(authToken) async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/forum/1/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $authToken'
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    logger.d(response.body);
    return Forum.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load forum');
  }
}

class Forum {
  final String title;
  final String content;
  final int author;

  const Forum(
      {required this.title, required this.content, required this.author});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      title: json['title'],
      content: json['content'],
      author: json['author'],
    );
  }
}

class _ForumScreen extends State<ForumScreen> {
  List<int> _likesCount = List.generate(20, (index) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewPostScreen(
                          authToken: authToken,
                        )),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 2, // number of posts

        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    // '$index. Highly Recommended',
                    'Highly Recommended',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bath and Beyond should be your go-to place for tiles in this city',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _likesCount[index]++;
                          });
                        },
                        icon: const Icon(Icons.thumb_up),
                      ),
                      Text('${_likesCount[index]} likes'),
                      IconButton(
                        onPressed: () {
                          // ADD A TEXTBOX FOR COMMENT AND KEEP COUNT OF COMMENTS
                          // setState(() {
                          //   _likesCount[index]++;
                          // });
                          getForumAll(authToken);
                        },
                        icon: const Icon(Icons.comment),
                      ),
                      const Text('3 comments'),
                      // Text('${_commentsCount[index]} comments'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            authToken: authToken,
                          )),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calculate),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalculatorScreen(
                            authToken: authToken,
                          )),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MarketplaceScreen(
                            authToken: authToken,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Select an option',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                  // Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help Center'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  );
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
