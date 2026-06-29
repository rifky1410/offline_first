import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register Dio
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // Register News Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: locator<Dio>(),
    ),
  );
}