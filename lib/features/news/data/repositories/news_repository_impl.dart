import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource remoteDatasource;

  NewsRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ArticleEntity>> getArticles() async {
    final list = await remoteDatasource.fetchNews();
    
    // LOGIKA WAJIB: Sorting Z-A (Descending)
    list.sort((a, b) => b.title.compareTo(a.title));
    
    return list;
  }
}