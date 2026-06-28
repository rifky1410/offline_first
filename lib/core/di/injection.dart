import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';
import '../../features/news/data/datasources/news_remote_datasource.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Network
  locator.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: EnvConfig.baseUrl)));

  // Data
  locator.registerLazySingleton(() => NewsRemoteDatasource(locator()));
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(locator()));

  // Bloc/Cubit
  locator.registerFactory(() => NewsCubit(locator()));
}