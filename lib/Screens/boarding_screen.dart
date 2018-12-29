import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';

class BoardingScreen extends StatefulWidget {

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen>
    with TickerProviderStateMixin {

  String _name = "";

  Future<String> getNamePreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("userName") ?? "";
    });
    return prefs.getString("userName") ?? "";
  }

  AnimationController _subheadingController;
  Animation<double> _subheadingOpacity;

  AnimationController _headingController;
  Animation<double> _headingOpacity;

  @override
  void initState() {
    super.initState();

    getNamePreferences()
      .then((value) {
        if(value.isNotEmpty){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });

    _subheadingController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _subheadingOpacity =
        new CurvedAnimation(parent: _subheadingController, curve: Curves.easeIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _subheadingController.dispose();
            } else if (status == AnimationStatus.dismissed) {
              _subheadingController.forward();
            }
          });
    _subheadingController.forward();

    _headingController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _headingOpacity =
        new CurvedAnimation(parent: _headingController, curve: Curves.easeIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _headingController.dispose();
            } else if (status == AnimationStatus.dismissed) {
              _headingController.forward();
            }
          });
    _headingController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _headingController.dispose();
    _subheadingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: new Center(
        child: Column(
          children: <Widget>[
            new FadeTransition(
              opacity: _headingOpacity,
              child: new Text(
                'Hi there,',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: "Signika",
                    fontWeight: FontWeight.w600),
              ),
            ),
            new FadeTransition(
              opacity: _headingOpacity,
              child: new Text(
                "I'm Reflectly",
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: "Signika",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: new FadeTransition(
                opacity: _subheadingOpacity,
                child: new Text(
                  "Your new personal",
                  style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                      fontFamily: "Signika",
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            new FadeTransition(
              opacity: _subheadingOpacity,
              child: new Text(
                "journaling experience",
                style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 25.0,
                    fontFamily: "Signika",
                    fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
      ),
    );

    final bottom = new Container(
      child: Column(
        children: <Widget>[
          new FadeTransition(
            opacity: _headingOpacity,
            child: new RaisedButton(
              onPressed: signup,
              elevation: 15.0,
              color: Colors.white,
              textColor: Colors.deepPurpleAccent,
              padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Text(
                "Hi, Reflectly!",
                style: TextStyle(fontSize: 20.0, fontFamily: "Signika"),
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 32.0)),
          new GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SigninScreen()));
            },
            child: new Text(
              "I ALREADY HAVE AN ACCOUNT",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontFamily: "Signika",
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 64.0)),
          new Text(
            "By creating a new acount or signing in with Facebook you are agreeing to our "
                "terms of service and privacy policy",
            style: new TextStyle(
              color: Colors.grey,
              fontSize: 10.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return new Scaffold(
      body: new Column(
        children: <Widget>[
          top,
          new Padding(padding: EdgeInsets.only(top: 275.0)),
          bottom
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
  }

  void signup() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }
}
