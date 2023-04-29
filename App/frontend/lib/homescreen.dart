import 'package:flutter/material.dart';
import 'package:flutterfrontend/HelpCenter.dart';
import 'Marketplace.dart';
import 'main.dart';
import 'Calculator.dart';
import 'Forum.dart';
import 'Marketplace.dart';
import 'Profile.dart';
import 'Drawer.dart';

class HomeScreen extends StatelessWidget {
  final String authToken;
  const HomeScreen({Key? key, required this.authToken}) : super(key: key);

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
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalculatorScreen(authToken: authToken,)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calculate),
                  const SizedBox(width: 8),
                  const Text('Calculator'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ForumScreen(authToken: authToken,)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.forum),
                  const SizedBox(width: 8),
                  const Text('Forum'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  MarketplaceScreen(authToken: authToken,)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_basket),
                  const SizedBox(width: 8),
                  const Text('Marketplace'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
