import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'home_tab_screen.dart';

int _current_index = 0;
final List<Widget> _children = [
  new Container(
    color: Colors.white,
    child: new HomeTabScreen(),
  ),
  new Container(
    color: Colors.white,
    child: new Center(
        child: new Text(
            "Messages"
        )
    ),
  ),
  new Container(
    color: Colors.white,
    child: new Center(
        child: new Text(
            "Profile"
        )
    ),
  ),
];

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    final bottom_nav =  new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(
              Icons.home
          ),
          title: new Text(
            "Home"
          )
        ),
        new BottomNavigationBarItem(
          icon: new Icon(
              Icons.mail
          ),
          title: new Text(
            "Messages"
          )
        ),
        new BottomNavigationBarItem(
          icon: new Icon(
            Icons.person
          ),
          title: new Text(
            "Profile"
          )
        )
      ],
      currentIndex: _current_index,
      onTap: _onTabTapped,
    );

    return new Scaffold(
      body: _children[_current_index],
      bottomNavigationBar: bottom_nav,
    );
  }


  void _onTabTapped(int index) {
    setState(() {
      _current_index = index;
    });
  }
}