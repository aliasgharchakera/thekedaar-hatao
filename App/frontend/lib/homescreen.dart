import 'package:flutter/material.dart';
import 'Marketplace.dart';
import 'main.dart';
import 'Calculator.dart';
import 'Forum.dart';
import 'Marketplace.dart';
import 'Profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      builder: (context) => const CalculatorScreen()),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ForumScreen()),
                // );
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const MarketplaceScreen()),
                // );
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
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Privacy'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfileScreen()),
                  // );
                  // Navigator.pop(context); // added statement
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Help Center'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Tabs extends StatelessWidget {
//   const Tabs({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('My App'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.calculate)),
//               Tab(icon: Icon(Icons.forum)),
//               Tab(icon: Icon(Icons.shopping_basket)),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             const CalculatorScreen(),
//             const ForumScreen(),
//             const MarketplaceScreen(),
//           ],
//         ),
//         drawer: Drawer(
//           child: Container(
//             color: Colors.white,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 DrawerHeader(
//                   decoration: const BoxDecoration(
//                     color: Colors.orange,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Menu',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Select an option',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.person),
//                   title: const Text('Profile'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ProfileScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const Text('Settings'),
//                   onTap: () {},
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.privacy_tip),
//                   title: const Text('Privacy'),
//                   onTap: () {},
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.help),
//                   title: const Text('Help Center'),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
