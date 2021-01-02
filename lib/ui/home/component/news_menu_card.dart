import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';

class NewsMenuCardWidget extends StatelessWidget {
  final Article article;

  const NewsMenuCardWidget({this.article});

  @override
  Widget build(BuildContext context) {
    if (article != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: buildNewsCard(context),
      );
    } else {
      return buildPlaceHolder;
    }
  }

  Widget buildNewsCard(BuildContext ctx) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          ctx,
          '/detail',
          arguments: article,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          width: 45,
          decoration: BoxDecoration(
            color: Color(0xffE7E7E7),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(1.1, 1.1), blurRadius: 5.0),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: buildImage(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                  article.title.substring(
                      0, article.title.lastIndexOf('-') > 0 ? article.title.lastIndexOf('-') : article.title.length),
                  style: TextStyle(
                    fontFamily: 'OpenSans-Bold',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      article.source.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'OpenSans', color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Image buildImage() {
    if (article.urlToImage != null) {
      return Image.network(
        article.urlToImage,
        fit: BoxFit.cover,
        height: 100,
        width: 150,
        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          return Image.asset(
            "assets/app_icon538.png",
            fit: BoxFit.cover,
          );
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      );
    } else {
      return Image.asset(
        "assets/app_icon538.png",
        fit: BoxFit.cover,
      );
    }
  }

  Container get buildPlaceHolder => Container(color: Colors.grey[200]);
}
