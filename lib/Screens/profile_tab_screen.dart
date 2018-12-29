import 'package:flutter/material.dart';

class ProfileTabScreen extends StatefulWidget{
  
  @override
  _ProfileTabScreenState createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen>{

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallback = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    final _body = new Container(
      child: new Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: _showPersBottomSheetCallback,
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: new Text("Persistent BS"),
              ),
              new RaisedButton(
                onPressed: _showModalBottomSheetCallback,
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: new Text("Modal BS"),
              )
            ],
          ),
        ),
      ),
    );

    return new Scaffold(
      body: _body,
    );
  }

  void _showModalBottomSheetCallback() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          color: Colors.green,
          child: new Center(
            child: new Text("Bottom sheet"),
          ),
        );
      }
    );
  }

  void _showBottomSheet() {
    showBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          color: Colors.red,
          child: new Center(
            child: new Text("Bottom sheet"),
          ),
        );
      }
    );
  }
}