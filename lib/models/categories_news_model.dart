class CategoriesNewsModel {
  String status;
  int totalResults;
  List<Article> articles;

  CategoriesNewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  // ignore: strict_top_level_inference
  static Future<CategoriesNewsModel> fromJson(body) async {
    final json = body as Map<String, dynamic>;
    final articlesJson = json['articles'] as List<dynamic>? ?? [];

    final articles = articlesJson.map((articleJson) {
      final articleMap = articleJson as Map<String, dynamic>;
      final sourceMap = articleMap['source'] as Map<String, dynamic>?;
      final publishedAtString = articleMap['publishedAt'] as String?;

      return Article(
        source: Source(
          id: sourceMap?['id'] as String?,
          name: sourceMap?['name'] as String? ?? '',
        ),
        author: articleMap['author'] as String?,
        title: articleMap['title'] as String? ?? '',
        description: articleMap['description'] as String?,
        url: articleMap['url'] as String? ?? '',
        urlToImage: articleMap['urlToImage'] as String?,
        publishedAt: publishedAtString != null
            ? DateTime.parse(publishedAtString)
            : DateTime.now(),
        content: articleMap['content'] as String? ?? '',
      );
    }).toList();

    return CategoriesNewsModel(
      status: json['status'] as String? ?? '',
      totalResults: json['totalResults'] as int? ?? 0,
      articles: articles,
    );
  }
}

class Article {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
}

class Source {
  String? id;
  String name;

  Source({required this.id, required this.name});
}
