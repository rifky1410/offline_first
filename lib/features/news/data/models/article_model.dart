import '../../domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.title,
    required super.description,
    required super.urlToImage,
    required super.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}