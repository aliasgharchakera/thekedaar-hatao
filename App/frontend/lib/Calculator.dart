import 'package:flutter/material.dart';
import 'package:flutterfrontend/Marketplace.dart';
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
                  _brickQuantity = quantity *
                      4.2; // considering the length of the brick is 8" and the width is 4"
                  _cementQuantity = quantity * 0.2;
                  _woodQuantity = quantity * 15;
                  _sandQuantity = quantity * 3.9;
                  _metalQuantity = quantity * 0.32;
                });
              },
              child: const Text('Calculate'),
            ),
            // Table(
            //   defaultColumnWidth: FixedColumnWidth(120.0),
            //   border: TableBorder.all(
            //       color: Colors.black, style: BorderStyle.solid, width: 2),
            //   children: [
            //     TableRow(children: [
            //       Column(children: const [
            //         Text('Material', style: TextStyle(fontSize: 20.0))
            //       ]),
            //       Column(children: const [
            //         Text('Quantity', style: TextStyle(fontSize: 20.0))
            //       ]),
            //     ]),
            //     TableRow(children: [
            //       Column(children: const [Text('Brick (pcs)')]),
            //       Column(children: [Text('$_brickQuantity')]),
            //     ]),
            //     TableRow(children: [
            //       Column(children: const [Text('Cement (kg)')]),
            //       Column(children: [Text('$_cementQuantity')]),
            //     ]),
            //     TableRow(children: [
            //       Column(children: const [Text('Metal (sqft)')]),
            //       Column(children: [Text('$_metalQuantity')]),
            //     ]),
            //     TableRow(children: [
            //       Column(children: const [Text('Sand (kg)')]),
            //       Column(children: [Text('$_sandQuantity')]),
            //     ]),
            //   ],
            // )

            // Card(
            //   elevation: 4,
            //   margin: EdgeInsets.symmetric(horizontal: 16),
            //   child: Padding(
            //     padding: EdgeInsets.all(16),
            //     child: Container(
            //       width: double.infinity,
            //       child: Table(
            //         columnWidths: {
            //           0: FlexColumnWidth(2),
            //           1: FlexColumnWidth(1),
            //         },
            //         border: TableBorder.all(
            //           color: Colors.grey.withOpacity(0.5),
            //           width: 1,
            //         ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                    },
                    border: TableBorder.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Material',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Brick (pcs)',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                '$_brickQuantity',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Cement (per bag)',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                '$_cementQuantity',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Metal (per ton)',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                '$_metalQuantity',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Sand (c.ft)',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                '$_sandQuantity',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MarketplaceScreen(
                            authToken: authToken,
                          )),
                );
              },
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
                      builder: (context) => ProfileScreen(
                        authToken: authToken,
                      ),
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
