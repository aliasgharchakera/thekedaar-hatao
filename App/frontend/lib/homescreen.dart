import 'package:flutter/material.dart';
import 'Marketplace.dart';
import 'Calculator.dart';
import 'Forum.dart';
import 'Drawer.dart';

class HomeScreen extends StatelessWidget {
  final String authToken;
  const HomeScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.calculate),
                  SizedBox(width: 8),
                  Text('Calculator'),
                ],
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.forum),
                  SizedBox(width: 8),
                  Text('Forum'),
                ],
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8),
                  Text('Marketplace'),
                ],
              ),
            ),
          ],
        ),
      ),     
      drawer: const CustomDrawer(),
    );
  }
}
