import 'package:dio/dio.dart';
import '../models/article_model.dart';

class NewsRemoteDatasource {
  final Dio dio;
  
  // Konstruktor menggunakan named parameter agar rapi
  NewsRemoteDatasource({required this.dio});

  // Nama method disamakan dengan yang dipanggil di NewsRepositoryImpl
  Future<List<ArticleModel>> getNewsFromApi() async {
    try {
      // Menggunakan full URL NewsAPI 
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines', 
        queryParameters: {
          'country': 'us',
          'category': 'technology', // Opsional: Berita teknologi
          'apiKey': '1ce83f90cbd8497093e339fb324c3fec', // API Key milikmu
        },
      );

      // Mengambil array 'articles' dari JSON
      final List<dynamic> data = response.data['articles'];
      
      // Mapping JSON mentah menjadi list of ArticleModel
      return data.map((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal menarik data berita dari API: $e');
    }
  }
}