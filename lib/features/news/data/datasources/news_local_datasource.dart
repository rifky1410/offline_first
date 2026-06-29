import 'package:isar/isar.dart';
import '../../domain/entities/article_entity.dart';
import '../models/article_model.dart';

abstract class NewsLocalDatasource {
  Future<List<ArticleEntity>> getArticles();
  Future<void> saveArticles(List<ArticleModel> articles);
}

class NewsLocalDatasourceImpl implements NewsLocalDatasource {
  final Isar isar;

  NewsLocalDatasourceImpl({required this.isar});

  @override
  Future<List<ArticleEntity>> getArticles() async {
    final articles = await isar.articleModels.where().findAll();
    return articles.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveArticles(List<ArticleModel> articles) async {
    await isar.writeTxn(() async {
      await isar.articleModels.clear();
      await isar.articleModels.putAll(articles);
    });
  }
}
