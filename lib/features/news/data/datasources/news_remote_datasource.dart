import 'package:dio/dio.dart';
import '../../../../core/config/env_config.dart';
import '../models/article_model.dart';

class NewsRemoteDatasource {
  final Dio dio;

  NewsRemoteDatasource({required this.dio});

  Future<List<ArticleModel>> getNewsFromApi() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'us',
        'category': 'technology',
        'apiKey': EnvConfig.apiKey,
      },
    );
    final List<dynamic> data = response.data['articles'];
    return data.map((json) => ArticleModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
