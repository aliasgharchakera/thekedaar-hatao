import 'package:flutter/material.dart';
import 'Drawer.dart';
import 'appbar.dart';

class CalculatorScreen extends StatefulWidget {
  final String authToken;
  const CalculatorScreen({Key? key, required this.authToken}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _quantityController = TextEditingController();

  double _sandQuantity = 0;
  double _cementQuantity = 0;
  double _brickQuantity = 0;
  double _woodQuantity = 0;
  double _metalQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Calculator',
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
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Area in sq/ft',
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
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
                        children: const [
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
                          const TableCell(
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
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '$_brickQuantity',
                                style: const TextStyle(
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
                          const TableCell(
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
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '$_cementQuantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const TableCell(
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
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '$_metalQuantity',
                                style: const TextStyle(
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
                          const TableCell(
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
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '$_woodQuantity',
                                style: const TextStyle(
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
                          const TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Wood (c.ft)',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '$_sandQuantity',
                                style: const TextStyle(
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
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(authToken: widget.authToken),
      drawer: const CustomDrawer(),
    );
  }
}
