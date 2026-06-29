import '../datasources/news_remote_datasource.dart';
import '../datasources/news_local_datasource.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource remoteDataSource;
  final NewsLocalDatasource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      final models = await remoteDataSource.getNewsFromApi();

      // Cache ke Isar setelah berhasil fetch
      await localDataSource.saveArticles(models);

      // Anti-AI: NIM 20123021 berakhiran 1 (Ganjil) -> Sort Z ke A (Descending)
      final entities = models.map((m) => m.toEntity()).toList();
      entities.sort((a, b) => b.title.compareTo(a.title));
      return entities;
    } catch (_) {
      // Offline fallback: ambil dari Isar
      final cached = await localDataSource.getArticles();
      if (cached.isEmpty) rethrow;
      cached.sort((a, b) => b.title.compareTo(a.title));
      return cached;
    }
  }
}
