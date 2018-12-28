import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

bool showEmailError = false;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupScreen extends StatefulWidget{
  @override
  _SignupScreenState createState() => _SignupScreenState();

}

class _SignupScreenState extends State<SignupScreen>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 32.0),
              child: new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: new Text(
                      "Signup",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new TextField(
              decoration: new InputDecoration(
                labelText: "What do your friends call you?",
                labelStyle: new TextStyle(
                  color: Colors.white,
                )
              ),
              keyboardType: TextInputType.text,
            ),
            new TextField(
              decoration: new InputDecoration(
                labelText: "Email",
                  labelStyle: new TextStyle(
                    color: Colors.white,
                  ),
                  errorText: showEmailError ? "Please enter a valid email" : null
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: validateEmail,
            ),
            new TextField(
              decoration: new InputDecoration(
                labelText: "Password",
                  labelStyle: new TextStyle(
                    color: Colors.white,
                  )
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 24.0),
              child: new RaisedButton(
                elevation: 5.0,
                onPressed: signup,
                color: Colors.white,
                textColor: Colors.deepPurpleAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text(
                    "Sign up",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Signika"
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new RaisedButton(
                onPressed: signupWithGoogle,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                color: Colors.white,
                textColor: Colors.deepPurpleAccent,
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Image.asset(
                        "assets/glogo.png",
                        height: 20.0,
                        width: 20.0,
                      ),
                      new SizedBox(width: 16.0),
                      new Text(
                        "Sign in with Google",
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Signika"
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateEmail(String value) {
    if(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
      setState(() {
        showEmailError = false;
      });
    } else {
      setState(() {
        showEmailError = true;
      });
    }
  }


  void signup() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => HomeScreen())
    );
  }

  void signupWithGoogle() {
    _handleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    return user;
  }
}