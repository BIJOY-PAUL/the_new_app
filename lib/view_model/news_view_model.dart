import 'package:flutter/foundation.dart';
import 'package:my_news_app/models/categories_news_model.dart';
import 'package:my_news_app/models/news_channels_headlines_model.dart';
import 'package:my_news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChanelsHeadlinesModel> fetchNewsChannelHeadlines(
    String name,
  ) async {
    final response = await _rep.fetchNewsChannelHeadlines(name);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriNewmodel(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
