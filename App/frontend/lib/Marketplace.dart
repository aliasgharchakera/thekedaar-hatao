// import 'package:flutter/material.dart';
// import 'package:thekedaar_hatao/Calculator.dart';
// import 'package:thekedaar_hatao/Forum.dart';
// import 'package:thekedaar_hatao/SellItem.dart';
// import 'homescreen.dart';
// import './Calculator.dart';
// import './main.dart';
// import 'Profile.dart';

// class MarketplaceScreen extends StatefulWidget {
//   const MarketplaceScreen({Key? key}) : super(key: key);

//   StatefulWidget.createState() => _MarketplaceScreenState();

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
//           ),
//           // const SizedBox(height: 100),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const SellItemScreen()),
//               );
//             },
//             child: const Text(
//               'List an item to sell',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text(
//           'MarketPlace Screen',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
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
//               icon: const Icon(Icons.calculate),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const CalculatorScreen()),
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
