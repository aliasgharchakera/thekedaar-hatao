import 'package:flutter/material.dart';
import './Calculator.dart';
import './Forum.dart';
import './SellItem.dart';
import 'homescreen.dart';
import './Calculator.dart';
import './main.dart';
import 'Profile.dart';
import './HelpCenter.dart';

class MarketplaceScreen extends StatefulWidget {
  final String authToken;
  const MarketplaceScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class MarketplaceItem {
  final String name;
  final String description;
  final double price;
  bool isFavorite;

  MarketplaceItem({
    required this.name,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<MarketplaceItem> _items = [];

  @override
  void initState() {
    super.initState();
    // Create dynamic items here
    _items = [
      MarketplaceItem(
        name: 'Cement',
        description: 'A bag of cement for construction.',
        price: 10.0,
      ),
      MarketplaceItem(
        name: 'Bricks',
        description: 'A bundle of bricks for construction.',
        price: 20.0,
      ),
      MarketplaceItem(
        name: 'Sand',
        description: 'A truckload of sand for construction.',
        price: 50.0,
      ),
      MarketplaceItem(
        name: 'Metal',
        description: 'A sheet of metal for construction.',
        price: 100.0,
      ),
      MarketplaceItem(
        name: 'Wood',
        description: 'A bundle of wood for construction.',
        price: 30.0,
      ),
      MarketplaceItem(
        name: 'Sand',
        description: 'A truckload of Sand for construction.',
        price: 30.0,
      ),
    ];
  }

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
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _items[index];
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
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price: ${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(item.isFavorite ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      item.isFavorite = !item.isFavorite;
                    });
                  },
                ),
                onTap: () {
                  // TODO: navigate to item details screen
                },
              ));
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
                  MaterialPageRoute(builder: (context) =>  HomeScreen(authToken: authToken,)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calculate),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  CalculatorScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.forum),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ForumScreen(authToken: authToken,)),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement the action to sell an item
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SellItemScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
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
