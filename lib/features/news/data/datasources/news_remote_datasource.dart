import 'package:dio/dio.dart';
import '../models/article_model.dart';

class NewsRemoteDatasource {
  final Dio dio;
  NewsRemoteDatasource(this.dio);

  Future<List<ArticleModel>> fetchNews() async {
    // API Call ke top-headlines
    final response = await dio.get('top-headlines', queryParameters: {
      'country': 'us',
    });

    final List<dynamic> data = response.data['articles'];
    return data.map((json) => ArticleModel.fromJson(json)).toList();
  }
}