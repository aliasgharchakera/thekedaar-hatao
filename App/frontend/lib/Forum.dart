import 'package:flutter/material.dart';
import 'CreatePostScreen.dart';
import 'appbar.dart';
import './main.dart';
import 'dart:async';
import 'dart:convert';
import 'Drawer.dart';
import 'package:http/http.dart' as http;

class ForumScreen extends StatefulWidget {
  final String authToken;
  const ForumScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _ForumScreen createState() => _ForumScreen();
}

List<ForumPost> posts = [];
Future<List<ForumPost>> getForumAll(authToken) async {
  final response = await http.get(
    Uri.parse('$URL/forum/'),
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
    posts = List<ForumPost>.from(l.map((model) => ForumPost.fromJson(model)));
    // logger.d(posts[0].title);
    return posts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load forum');
  }
}

class Comment {
  final String comment;
  final String username;

  const Comment({required this.comment, required this.username});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      username: json['username'],
    );
  }
}

class ForumPost {
  final int id;
  final String title;
  final String content;
  final String username;
  final List<Comment> comments;

  const ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.username,
    required this.comments,
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    Iterable l = json['comments'];
    List<Comment> comments =
        List<Comment>.from(l.map((model) => Comment.fromJson(model)));

    return ForumPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      username: json['username'],
      comments: comments,
    );
  }
}

class _ForumScreen extends State<ForumScreen> {
  final List<int> _likesCount = List.generate(20, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Forum',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<ForumPost>>(
        future: getForumAll(widget.authToken),
        builder:
            (BuildContext context, AsyncSnapshot<List<ForumPost>> snapshot) {
          if (snapshot.hasData) {
            List<ForumPost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                ForumPost post = posts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(post: post),
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
                            style: const TextStyle(
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
                                  if (authToken.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PostScreen(post: post),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.comment),
                              ),
                              Text('${post.comments.length} comments'),
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
            return const Center(child: Text('Failed to load forum'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(authToken: widget.authToken),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (authToken.isNotEmpty) {
            final success = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreatePostScreen(authToken: widget.authToken),
              ),
            );
            if (success == true) {
              setState(() {
                posts.clear();
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login to create a post'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostScreen extends StatefulWidget {
  final ForumPost post;

  const PostScreen({required this.post, Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String comment = '';
  final _commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Comment Section'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 510.0, // Replace with your desired width
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(widget.post.content),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.post.comments.length,
              itemBuilder: (BuildContext context, int index) {
                Comment comment = widget.post.comments[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(comment.comment),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _commentController,
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (authToken.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You must be logged in to comment'),
                    ),
                  );
                  return;
                } else if (comment.isNotEmpty) {
                  // call your API endpoint to create a comment
                  int id = widget.post.id;
                  final response = await http.post(
                    Uri.parse('$URL/forum/$id/create/'),
                    headers: <String, String>{
                      'Authorization': 'Token $authToken'
                    },
                    body: {
                      'comment': comment,
                    },
                  );
                  comment = '';
                  _commentController.clear();
                  // refresh the page to show the new comment
                  setState(() {
                    comment = '';
                    widget.post.comments
                        .add(Comment.fromJson(json.decode(response.body)));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment cannot be empty'),
                    ),
                  );
                }
              },
              child: const Text('Comment'),
            ),
          ),
        ],
      ),
    );
  }
}
