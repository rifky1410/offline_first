import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../config/env_config.dart';
import '../database/isar_manager.dart';
import '../native/method_channel_helper.dart';
import '../../features/news/data/datasources/news_remote_datasource.dart';
import '../../features/news/data/datasources/news_local_datasource.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/domain/usecases/get_articles.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Isar
  final isar = await IsarManager.initialize();
  locator.registerSingleton<Isar>(isar);

  // Dio
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
    return dio;
  });

  // Data Sources
  locator.registerLazySingleton<NewsRemoteDatasource>(
    () => NewsRemoteDatasource(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<NewsLocalDatasource>(
    () => NewsLocalDatasourceImpl(isar: locator<Isar>()),
  );

  // Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: locator<NewsRemoteDatasource>(),
      localDataSource: locator<NewsLocalDatasource>(),
    ),
  );

  // Use Cases
  locator.registerLazySingleton<GetArticles>(
    () => GetArticles(locator<NewsRepository>()),
  );

  // BLoC / Cubit
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<GetArticles>()),
  );

  // Native
  locator.registerLazySingleton<MethodChannelHelper>(() => MethodChannelHelper());
}
