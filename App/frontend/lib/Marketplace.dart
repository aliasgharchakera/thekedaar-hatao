import 'package:flutter/material.dart';
import './Calculator.dart';
import './Forum.dart';
import './SellItem.dart';
import 'homescreen.dart';
import './Calculator.dart';
import './main.dart';
import 'Profile.dart';
import './HelpCenter.dart';
import 'drawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketplaceScreen extends StatefulWidget {
  final String authToken;
  const MarketplaceScreen({Key? key, required this.authToken})
      : super(key: key);

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

List<MarketPlacePost> posts = [];
Future<List<MarketPlacePost>> getMarketPlace(authToken) async {
  final response = await http.get(
    Uri.parse('$URL/marketplace/'),
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
    posts = List<MarketPlacePost>.from(
        l.map((model) => MarketPlacePost.fromJson(model)));
    logger.d(posts);
    return posts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load marketplace posts');
  }
}

class MarketPlacePost {
  final int id;
  final String material;
  final double price;
  final String username;
  final int quantity;

  const MarketPlacePost({
    required this.id,
    required this.material,
    required this.price,
    required this.username,
    required this.quantity,
  });

  factory MarketPlacePost.fromJson(Map<String, dynamic> json) {
    return MarketPlacePost(
      id: json['id'],
      material: json['material'],
      price: json['price'],
      username: json['username'],
      quantity: json['quantity'],
    );
  }
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
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
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<MarketPlacePost>>(
        future: getMarketPlace(widget.authToken),
        builder: (BuildContext context,
            AsyncSnapshot<List<MarketPlacePost>> snapshot) {
          if (snapshot.hasData) {
            List<MarketPlacePost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(posts[index].material),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts[index].username,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Price: ${posts[index].price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Quantity: ${posts[index].quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
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
              icon: const Icon(Icons.forum),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForumScreen(
                            authToken: authToken,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (authToken.isNotEmpty) {
            final success = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SellItemScreen(authToken: widget.authToken),
              ),
            );
            if (success == true) {
              setState(() {
                posts.clear();
              });
            }
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
