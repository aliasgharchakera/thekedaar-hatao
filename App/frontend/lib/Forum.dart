import 'package:flutter/material.dart';
import './AddNewPost.dart';
import './Calculator.dart';
import './Marketplace.dart';
import 'homescreen.dart';
import './Calculator.dart';
import './main.dart';
import 'Profile.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreen createState() => _ForumScreen();
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
                MaterialPageRoute(builder: (context) => const AddNewPostScreen()),
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
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calculate),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MarketplaceScreen()),
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
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Privacy'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Help Center'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
