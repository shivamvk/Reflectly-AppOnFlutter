import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SigninScreen extends StatefulWidget {

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: new Row(
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: new Text(
                  "Signin",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}