import 'package:isar/isar.dart';
import '../../domain/entities/article_entity.dart';

part 'article_model.g.dart';

@Collection()
class ArticleModel {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String urlToImage;
  String url = '';

  ArticleModel();

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final model = ArticleModel();
    model.title = json['title'] ?? 'Tanpa Judul';
    model.description = json['description'] ?? 'Tanpa Deskripsi';
    model.urlToImage = json['urlToImage'] ?? '';
    model.url = json['url'] ?? '';
    return model;
  }

  ArticleEntity toEntity() => ArticleEntity(
        title: title,
        description: description,
        urlToImage: urlToImage,
        url: url,
      );
}
