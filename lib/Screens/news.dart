import 'dart:convert';

class News{
  final String status;
  final int totalResults;
  final List<Article> articles;

  const News({
    this.status,
    this.totalResults,
    this.articles
  });
  
  factory News.fromJson(Map<String, dynamic> json){

    var list = json['articles'] as List;

    List<Article> articles = list.map(
        (i) => Article.fromJson(i)
    ).toList();

    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articles
    );
  }
}

class Article{
  final String author;
  final String title;
  final String urlToImage;
  final String description;

  const Article({
    this.author,
    this.title,
    this.urlToImage,
    this.description
  });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      author: json['author'],
      title: json['title'],
      urlToImage: json['urlToImage'],
      description: json['description']
    );
  }
}