import 'package:flutter/material.dart';
import 'package:flutterfrontend/Marketplace.dart';
import 'EditProfile.dart';
import 'Forum.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'Drawer.dart';
import 'appbar.dart';
import 'package:http/http.dart' as http;

class VendorScreen extends StatefulWidget {
  final String authToken;
  final int userId;
  const VendorScreen({Key? key, required this.authToken, required this.userId})
      : super(key: key);

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

List<UserPost> posts = [];
Future<List<UserPost>> getUserPosts(userId) async {
  final response = await http.get(
    Uri.parse('$URL/vendor/$userId/posts/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Token $authToken'
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // logger.d(response.body);
    Iterable l = json.decode(response.body);
    posts = List<UserPost>.from(l.map((model) => UserPost.fromJson(model)));
    // logger.d(posts[0].title);
    return posts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    logger.d(response.body);
    throw Exception('Failed to load posts');
  }
}

Future<User> getUser(userId) async {
  final response = await http.get(
    Uri.parse('$URL/vendor/$userId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Token $authToken',
    },
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return User.fromJson(json);
  } else {
    throw Exception('Failed to load user');
  }
}

class User {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String username;

  const User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      username: json['username'],
    );
  }
}

class UserPost {
  final int id;
  final String material;
  final double price;
  final int quantity;

  const UserPost({
    required this.id,
    required this.material,
    required this.price,
    required this.quantity,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['id'],
      material: json['material'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Vendor Info',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FutureBuilder<User>(
          future: getUser(widget.userId),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarketplaceScreen(
                          authToken: authToken,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.first_name} ${user.last_name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load user'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Expanded(
          child: FutureBuilder<List<UserPost>>(
            future: getUserPosts(widget.userId),
            builder:
                (BuildContext context, AsyncSnapshot<List<UserPost>> snapshot) {
              if (snapshot.hasData) {
                List<UserPost> posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserPost post = posts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarketplaceScreen(
                              authToken: authToken,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.material,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: ${post.price.toString()}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Quantity: ${post.quantity.toString()}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load posts'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ]),
      bottomNavigationBar: MyBottomNavigationBar(authToken: widget.authToken),
      // drawer: const CustomDrawer(),
    );
  }
}
