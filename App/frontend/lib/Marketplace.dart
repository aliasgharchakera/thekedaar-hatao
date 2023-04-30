import 'package:flutter/material.dart';
import 'package:flutterfrontend/Drawer.dart';
import 'package:flutterfrontend/vendor.dart';
import './SellItem.dart';
import './main.dart';
import 'dart:async';
import 'appbar.dart';
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
    // logger.d(posts);
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
  final int user_id;
  final int quantity;

  const MarketPlacePost({
    required this.id,
    required this.material,
    required this.price,
    required this.username,
    required this.quantity,
    required this.user_id,
  });

  factory MarketPlacePost.fromJson(Map<String, dynamic> json) {
    return MarketPlacePost(
      id: json['id'],
      material: json['material'],
      price: json['price'],
      username: json['username'],
      quantity: json['quantity'],
      user_id: json['user_id'],
    );
  }
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<MarketPlacePost>>(
        future: getMarketPlace(widget.authToken),
        builder: (BuildContext context,
            AsyncSnapshot<List<MarketPlacePost>> snapshot) {
          if (snapshot.hasData) {
            List<MarketPlacePost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorScreen(
                            authToken: authToken,
                            userId: posts[index].user_id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: Text(posts[index].material),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username: ${posts[index].username}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
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
                      ),
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(authToken: widget.authToken),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (widget.authToken.isNotEmpty) {
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
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login to sell items'),
              ),
            );
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
