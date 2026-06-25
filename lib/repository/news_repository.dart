import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_news_app/models/news_channels_headlines_model.dart';

class NewsRepository {
  Future<NewsChanelsHeadlinesModel> fetchNewsChannelHeadlines(
    String name,
  ) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=7c1b8fd4cbec4e4cbd9c3e40e9856db8';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChanelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
