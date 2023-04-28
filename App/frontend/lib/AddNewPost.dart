import 'package:flutter/material.dart';
import 'main.dart';
import 'HelpCenter.dart';
import 'homescreen.dart';
import 'Calculator.dart';
import 'Marketplace.dart';
import 'Forum.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _username = 'JohnthemanDoe';
  String _email = 'johndoe@example.com';
  String _password = '********';

  Future<void> _editName() async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? name;
        return AlertDialog(
          title: const Text('Edit Name'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'New name',
            ),
            onChanged: (value) {
              name = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.pop(context, name);
              },
            ),
          ],
        );
      },
    );
    if (newName != null) {
      setState(() {
        _name = newName;
      });
    }
  }

  Future<void> _editusername() async {
    String? newuserName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? userName;
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'New username',
            ),
            onChanged: (value) {
              userName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.pop(context, userName);
              },
            ),
          ],
        );
      },
    );
    if (newuserName != null) {
      setState(() {
        _username = newuserName;
      });
    }
  }

  Future<void> _editEmail() async {
    String? newEmail = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? email;
        return AlertDialog(
          title: const Text('Edit Email'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'New email',
            ),
            onChanged: (value) {
              email = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.pop(context, email);
              },
            ),
          ],
        );
      },
    );
    if (newEmail != null) {
      setState(() {
        _email = newEmail;
      });
    }
  }

  Future<void> _editPassword() async {
    String? newPassword = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? oldPassword;
        String? newPassword;
        String? confirmedPassword;
        return AlertDialog(
          title: const Text('Edit Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current password',
                ),
                onChanged: (value) {
                  oldPassword = value;
                },
              ),
              TextField(
                autofocus: true,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New password',
                ),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
              TextField(
                autofocus: true,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm new password',
                ),
                onChanged: (value) {
                  confirmedPassword = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                if (oldPassword == _password &&
                    newPassword == confirmedPassword) {
                  Navigator.pop(context, newPassword);
                } else if (oldPassword != _password) {
                  // Show an error message if the old password is incorrect
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('The old password is incorrect.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Show an error message if the new passwords do not match
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('The new passwords do not match.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
    if (newPassword != null) {
      setState(() {
        // _password = newPassword;
      });
    }
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Name'),
            subtitle: Text(_name),
            onTap: _editName,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Username'),
            subtitle: Text(_username),
            onTap: _editusername,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Email'),
            subtitle: Text(_email),
            onTap: _editEmail,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Password'),
            subtitle: Text(_password),
            onTap: _editPassword,
          ),
        ],
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
              icon: const Icon(Icons.calculate),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorScreen()),
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
              icon: const Icon(Icons.shop),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
