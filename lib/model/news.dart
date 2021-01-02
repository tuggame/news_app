import 'package:news_app/model/article.dart';

class Newscast {
  Newscast({
    this.status,
    this.totalResults,
    this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory Newscast.fromJson(Map<String, dynamic> json) => Newscast(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
