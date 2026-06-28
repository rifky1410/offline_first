import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register Dio dengan BaseOptions
  locator.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      queryParameters: {'apiKey': EnvConfig.apiKey},
    ),
  ));
}