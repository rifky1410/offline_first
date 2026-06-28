import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> getArticles();
}