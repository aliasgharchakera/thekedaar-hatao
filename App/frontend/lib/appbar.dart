import 'package:flutter/material.dart';
import 'package:flutterfrontend/homescreen.dart';
import './homescreen.dart';
import './Calculator.dart';
import './Forum.dart';
import 'Marketplace.dart';


class MyBottomNavigationBar extends StatelessWidget {
  final String authToken;

  MyBottomNavigationBar({required this.authToken});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  ),
                ),
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
                  ),
                ),
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
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shop),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MarketplaceScreen(
                    authToken: authToken,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}