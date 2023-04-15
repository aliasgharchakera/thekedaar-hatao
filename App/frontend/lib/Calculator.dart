// import 'package:flutter/material.dart';
// import 'package:thekedaar_hatao/Forum.dart';
// import 'homescreen.dart';
// import './main.dart';
// import 'Profile.dart';

// class CalculatorScreen extends StatefulWidget {
//   const CalculatorScreen({Key? key}) : super(key: key);

//   @override
//   _CalculatorScreenState createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {
//   final List<String> _materials = [
//     'Select material',
//     'Brick',
//     'Wood',
//     'Cement',
//     'Sand',
//     'Metal'
//   ];
//   String? _selectedMaterial;
//   final TextEditingController _quantityController = TextEditingController();

//   bool _isMenuOpen = false;

//   void _toggleMenu() {
//     setState(() {
//       _isMenuOpen = !_isMenuOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton<String>(
//               value: _selectedMaterial,
//               items: _materials.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedMaterial = newValue;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: 200,
//               child: TextField(
//                 controller: _quantityController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Quantity in sq/ft',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('Calculate'),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.orange,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.forum),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ForumScreen()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.shopping_cart),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: Container(
//           color: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: const BoxDecoration(
//                   color: Colors.orange,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Menu',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Select an option',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileScreen()),
//                   );
//                   // Navigator.pop(context); // added statement
//                 },
//                 child: Row(
//                   children: const [
//                     Icon(Icons.person),
//                     SizedBox(width: 10),
//                     Text('Profile'),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileScreen()),
//                   );
//                   // Navigator.pop(context); // added statement
//                 },
//                 child: Row(
//                   children: const [
//                     Icon(Icons.person),
//                     SizedBox(width: 10),
//                     Text('Settings'),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileScreen()),
//                   );
//                   // Navigator.pop(context); // added statement
//                 },
//                 child: Row(
//                   children: const [
//                     Icon(Icons.person),
//                     SizedBox(width: 10),
//                     Text('Privacy'),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileScreen()),
//                   );
//                   // Navigator.pop(context); // added statement
//                 },
//                 child: Row(
//                   children: const [
//                     Icon(Icons.person),
//                     SizedBox(width: 10),
//                     Text('Help Center'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
