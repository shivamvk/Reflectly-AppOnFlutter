import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'news.dart';

Future<News> getArticles() async{
  var data = await
  http.get("https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=3d5998d023614120acefd255e7017c2a");

  var jsonData = json.decode(data.body);

  return News.fromJson(jsonData);
}

class NewsTabScreen extends StatefulWidget{
  @override
  _NewsTabScreenState createState() => _NewsTabScreenState();
}

class _NewsTabScreenState extends State<NewsTabScreen>{

  final _articles = new FutureBuilder(
    future: getArticles(),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data.articles.length,
          itemBuilder: (BuildContext context, int index){
            return new GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: new Text(
                        "Title goes here"
                      ),
                      content: new Text(
                        "Content goes here"
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "Close"
                          ),
                        )
                      ],
                    );
                  }
                );
              },
              child: Card(
                elevation: 10.0,
                color: Colors.white,
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Text(
                            snapshot.data.articles[index].title,
                            style: new TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: new Text(
                              snapshot.data.articles[index].author == null ?
                              "Unknown" : snapshot.data.articles[index].author,
                              style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: new FadeInImage.assetNetwork(
                          placeholder: 'assets/newsplace.png',
                          image: snapshot.data.articles[index].urlToImage,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else if (snapshot.hasError){
        return new Center(child: new Text('Error: ${snapshot.error}'),);
      }
      return CircularProgressIndicator();
    },
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(child: _articles),
    );
  }

}