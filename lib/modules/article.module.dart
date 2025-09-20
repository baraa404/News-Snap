class FullArticelsModel {
  FullArticelsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<ArticleModel> articles;

  factory FullArticelsModel.fromJson(Map<String, dynamic> json) {
    return FullArticelsModel(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: json["articles"] == null
          ? []
          : List<ArticleModel>.from(
              json["articles"]!.map((x) => ArticleModel.fromJson(x)),
            ),
    );
  }
}

class ArticleModel {
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      content: json["content"],
    );
  }
}

class Source {
  Source({required this.id, required this.name});

  final String? id;
  final String? name;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json["id"], name: json["name"]);
  }
}
