import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'home_tab_screen.dart';
import 'news_tab_screen.dart';
import 'profile_tab_screen.dart';
import 'boarding_screen.dart';

int _current_index = 0;
final List<Widget> _children = [
  new Container(
    color: Colors.white,
    child: new HomeTabScreen(),
  ),
  new Container(
    color: Colors.white,
    child: new NewsTabScreen(),
  ),
  new Container(
    color: Colors.white,
    child: new ProfileTabScreen(),
  ),
];

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    final bottom_nav = new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(
              Icons.assignment
          ),
          title: new Text(
            "Feed"
          )
        ),
        new BottomNavigationBarItem(
          icon: new Icon(
              Icons.featured_play_list
          ),
          title: new Text(
            "News"
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

    final drawer = new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                  "Shivam Bhasin"
              ),
              accountEmail: new Text(
                  "shivam.vk529@gmail.com"
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text(
                    "S"
                ),
              ),
            ),
            ListTile(
              title: Text('My orders'),
              trailing: new Icon(
                  Icons.arrow_forward_ios
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My passbook'),
              trailing: new Icon(
                  Icons.arrow_forward_ios
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('About us'),
              trailing: new Icon(
                  Icons.arrow_forward_ios
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Customer support'),
              trailing: new Icon(
                  Icons.arrow_forward_ios
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Log out'),
              trailing: new Icon(
                Icons.arrow_forward_ios
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return new AlertDialog(
                      content: new Text(
                        'Are you sure you want to log out?'
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: new Text('Cancel'),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => BoardingScreen())
                            );
                          },
                          child: new Text('Yes'),
                        )
                      ],
                    );
                  }
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              trailing: new Icon(
                  Icons.settings
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 0.0, 0.0),
              child: new Text("v1.0"),
            )
          ],
        ));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Reflectly'
        ),
      ),
      drawer: drawer,
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