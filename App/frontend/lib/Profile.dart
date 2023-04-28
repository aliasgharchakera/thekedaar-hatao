import 'package:flutter/material.dart';
import 'EditProfile.dart';
import 'Forum.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String authToken;
  const ProfileScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


List<UserPost> posts = [];
Future<List<UserPost>> getUserPosts(authToken) async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/user/posts/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $authToken'
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
    throw Exception('Failed to load posts');
  }
}

Future<User> getUser() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $authToken',
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
  final String title;
  final String content;
  final String username;

  const UserPost({
    required this.id,
    required this.title,
    required this.content,
    required this.username,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) {

    return UserPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      username: json['username'],
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {

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
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<User>(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                User user = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user.first_name} ${user.last_name}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                    authToken: widget.authToken,
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit Details'),
                          ),
                        ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load user'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Expanded(child: FutureBuilder<List<UserPost>>(
        future: getUserPosts(widget.authToken),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserPost>> snapshot) {
          if (snapshot.hasData) {
            List<UserPost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                UserPost post = posts[index];
                return GestureDetector(
                  onTap: () async {
                    final response = await http.get(
                      Uri.parse('http://127.0.0.1:8000/forum/${post.id}/'),
                      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $authToken'
    },
  ); ForumPost forumpost = ForumPost.fromJson(jsonDecode(response.body));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(post: forumpost),
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
                            post.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post.content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load posts'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
          ),
        ]
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
                      builder: (context) => ProfileScreen(authToken: authToken,),
                    ),
                  );
                  // Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // add functionality
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Privacy'),
                onTap: () {
                  // add functionality
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help Center'),
                onTap: () {
                  // add functionality
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}