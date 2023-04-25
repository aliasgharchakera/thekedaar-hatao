import 'package:flutter/material.dart';
import 'Forum.dart';
import 'homescreen.dart';
import 'main.dart';
import 'Profile.dart';
import 'HelpCenter.dart';

class CalculatorScreen extends StatefulWidget {
  final String authToken;
  const CalculatorScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String? _selectedMaterial;
  final TextEditingController _quantityController = TextEditingController();

  bool _isMenuOpen = false;
  double _multipliedQuantity = 0;
  double _sandQuantity = 0;
  double _cementQuantity = 0;
  double _brickQuantity = 0;
  double _woodQuantity = 0;
  double _metalQuantity = 0;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
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
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity in sq/ft',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final double quantity = double.parse(_quantityController.text);
                setState(() {
                  _brickQuantity = quantity * 2.5;
                  _cementQuantity = quantity * 0.5;
                  _woodQuantity = quantity * 0.5;
                  _sandQuantity = quantity * 0.5;
                  _metalQuantity = quantity * 0.5;
                });
              },
              child: const Text('Calculate'),
            ),
            Table(
              defaultColumnWidth: FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: const [
                    Text('Material', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: const [
                    Text('Quantity', style: TextStyle(fontSize: 20.0))
                  ]),
                ]),
                TableRow(children: [
                  Column(children: const [Text('Brick (pcs)')]),
                  Column(children: [Text('$_brickQuantity')]),
                ]),
                TableRow(children: [
                  Column(children: const [Text('Cement (kg)')]),
                  Column(children: [Text('$_cementQuantity')]),
                ]),
                TableRow(children: [
                  Column(children: const [Text('Metal (sqft)')]),
                  Column(children: [Text('$_metalQuantity')]),
                ]),
                TableRow(children: [
                  Column(children: const [Text('Sand (kg)')]),
                  Column(children: [Text('$_sandQuantity')]),
                ]),
              ],
            )
            // final int quantity = int.parse(_quantityController.text);
          ],
        ),
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
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
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
