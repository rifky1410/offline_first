import '../models/article_model.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  // Ganti tipe data dynamic ini dengan class RemoteDataSource kamu jika namanya berbeda
  final dynamic remoteDataSource; 

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      // 1. Ambil data mentah (berupa Model)
      final List<ArticleModel> models = await remoteDataSource.getNewsFromApi();

      // 2. Konversi / Mapping dari List<ArticleModel> menjadi List<ArticleEntity>
      List<ArticleEntity> entities = List<ArticleEntity>.from(models);

      // 3. Logika Anti-AI: Sort Descending (Z ke A) untuk NIM Ganjil
      entities.sort((a, b) => b.title.compareTo(a.title));

      return entities; 
    } catch (e) {
      throw Exception('Gagal mengambil data berita: $e');
    }
  }
}