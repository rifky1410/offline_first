import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetArticles {
  final NewsRepository repository;

  GetArticles(this.repository);

  Future<List<ArticleEntity>> call() => repository.getArticles();
}
