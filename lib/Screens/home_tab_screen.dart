import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'post.dart';

import 'dart:async';
import 'dart:convert';

Future<List<Post>> getPosts() async{

  var data = await http.get("https://jsonplaceholder.typicode.com/posts/");

  var jsonData = json.decode(data.body);

  List<Post> posts = [];

  for (var p in jsonData){
    Post post = new Post(
        userId: p['userId'],
        id: p['id'],
        title: p['title'],
        body: p['body']
    );

    posts.add(post);
  }

  return posts;
}

class HomeTabScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: new FutureBuilder(
              future: getPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      if(index == 0){
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 12.0),
                          child: new Text(
                            "Here's your feed!",
                            style: new TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontFamily: "Signika",
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Card(
                          elevation: 10.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new Text(
                                  snapshot.data[index].title,
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Signika",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                new Text(
                                  snapshot.data[index].body
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return CircularProgressIndicator();
              },
            ),
      ),
    );
  }
}