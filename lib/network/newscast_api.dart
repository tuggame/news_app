import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_app/model/api_error.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/news.dart';

// Base URL
const String _baseApiURL = 'https://newsapi.org';

// API Endpoints
const String _topHeadlines = '/v2/top-headlines?country=tr';
const String _everything = '/v2/everything?language=tr';
const String _sources = '/v2/sources';

const String api_key = 'c896082263d94628a58f14e237d1fb05';

enum NewsCategory {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}

enum SortBy {
  relevancy,
  popularity,
  publishedAt,
}
const String add_api_key = "&apiKey=${api_key}";
const String add_category = "&category=";

const String add_search = "&q=";
const String add_search_in_title = "&qInTitle=";
const String add_sort_by = "&sortBy="; // popularity // EVERTHING
const String add_from_date = "&from="; // 2020-12-24 // EVERTHING
const String add_to_date = "&to="; // 2020-12-24 // EVERTHING

const String add_domains = "&domains="; //haberturk.com , haber7.com, // EVERTHING

Newscast newscastFromJson(String str) => Newscast.fromJson(json.decode(str));

String newscastToJson(Newscast data) => json.encode(data.toJson());

class NewscastService {
  static NewscastService _singleton = NewscastService._internal();
  NewscastService._internal();

  factory NewscastService() {
    return _singleton;
  }

  static String _getCategory(NewsCategory category) {
    if (null == category) category = NewsCategory.general;
    return add_category + category.toString().split('.').last;
  }

  static Future<List<Article>> getNews({NewsCategory category = NewsCategory.general}) async {
    final response = await http.get(_baseApiURL + _topHeadlines + add_api_key + _getCategory(category));

    try {
      _checkResponse(response);

      if (response.body.isNotEmpty) {
        Newscast news = newscastFromJson(response.body);
        return news.articles;
      }
      return null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<List<Article>> getSearchResults({String searchTxt}) async {
    final response = await http
        .get(_baseApiURL + _everything + add_api_key + add_search + searchTxt + add_from_date + getYesterday());

    try {
      _checkResponse(response);

      if (response.body.isNotEmpty) {
        Newscast news = newscastFromJson(response.body);
        return news.articles;
      }
      return null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static String getYesterday() {
    final DateTime now = DateTime.now().subtract(Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static _checkResponse(http.Response response) {
    if (response.statusCode != 200) {
      // Try to build api_error object
      try {
        final APIError apiError = APIError.fromJson(json.decode(response.body));
        throw apiError;
      } on Exception catch (e) {
        // Rethrow
        if (e is APIError)
          throw e;
        else // Deserialization error
          throw Exception(response.body);
      }
    }
  }
}
