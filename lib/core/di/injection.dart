import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';

// Import file-file penting
import '../../features/news/data/datasources/news_remote_datasource.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // 1. Register Dio
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // 2. Register Remote Data Source
  locator.registerLazySingleton<NewsRemoteDatasource>(
    () => NewsRemoteDatasource(dio: locator<Dio>()),
  );

  // 3. Register News Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: locator<NewsRemoteDatasource>(),
    ),
  );

  // 4. Register News Cubit
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepository>()),
  );
}