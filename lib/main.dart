import 'package:flutter/material.dart';
import 'Screens/boarding_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: BoardingScreen(),
      theme: new ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        primaryColorDark: Colors.deepPurpleAccent
      ),
    );
  }
}