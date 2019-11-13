import 'package:flutter/material.dart';

//screens imports
import 'package:artisan_alpha/screens/profile/profile_page.dart';
import 'package:artisan_alpha/screens/browse/browse_page.dart';
import 'package:artisan_alpha/screens/message/messages_page.dart';

//services imports
import 'package:artisan_alpha/services/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _bottomNavChildren = [
    BrowsePage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Text('Artisan'),
        actions: <Widget>[
          FlatButton(
              onPressed: _signOut,
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ))
        ],
      ),  */
      body: _bottomNavChildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Browse'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
