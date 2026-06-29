import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';

// Import Data Source, Repository, dan Bloc/Cubit
import '../../features/news/data/datasources/news_remote_data_source.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // 1. Register Dio (Jaringan)
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // 2. Register Remote Data Source (Kurir API kita)
  locator.registerLazySingleton<NewsRemoteDatasource>(
    () => NewsRemoteDatasource(locator<Dio>()),
  );

  // 3. Register News Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      // Menggunakan named parameter sesuai yang kita perbaiki sebelumnya
      remoteDataSource: locator<NewsRemoteDatasource>(),
    ),
  );

  // 4. Register News Cubit (State Management)
  // Wajib menggunakan registerFactory untuk Bloc/Cubit agar state-nya selalu fresh
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepository>()),
  );
}