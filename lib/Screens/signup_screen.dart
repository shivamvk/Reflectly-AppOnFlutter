import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

bool showNameError = false;
bool showEmailError = false;
bool showPasswordError = false;

String _name = "";
String _email = "";
String _passwrord = "";

final _nameController = new TextEditingController();
final _emailController = new TextEditingController();
final _passwrodController = new TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class SignupScreen extends StatefulWidget{
  @override
  _SignupScreenState createState() => _SignupScreenState();

}

class _SignupScreenState extends State<SignupScreen>{

  Future<FirebaseUser> _signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: signInAuthentication.idToken,
      accessToken: signInAuthentication.accessToken
    );

    setState(() {
      _email = user.email;
    });

    return user;
  }

  void _signInWithGoogleSuccessful(FirebaseUser user){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => new HomeScreen(user: user))
    );
  }

  Future<FirebaseUser> _signInWithEmail() async {

    setState(() {
      _name = _nameController.text;
      _email = _emailController.text;
      _passwrord = _passwrodController.text;
    });

    FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _passwrord
    );

    setState(() {
      _email = user.email + user.isEmailVerified.toString();
    });

    return user;
  }

  final _formKey = new GlobalKey<FormState>();

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
            new Form(
              key: _formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new TextField(
                    decoration: new InputDecoration(
                        labelText: "What do your friends call you?",
                        labelStyle: new TextStyle(
                          color: Colors.white,
                        )
                    ),
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                        labelText: "What is your cool email?",
                        labelStyle: new TextStyle(
                          color: Colors.white,
                        ),
                        errorText: showEmailError ? "Please enter a valid email" : null
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onChanged: validateEmail,
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                        labelText: "What's your secret password?",
                        labelStyle: new TextStyle(
                          color: Colors.white,
                        )
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _passwrodController,
                  ),
                  new Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 24.0),
                    child: new RaisedButton(
                      elevation: 5.0,
                      onPressed: _signInWithEmail,
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
                      onPressed: () => _signInWithGoogle()
                        .then((FirebaseUser user) => _signInWithGoogleSuccessful(user))
                        .catchError((e) => print(e)),
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
}