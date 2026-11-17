import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_shower/data/repository/news_repository_impl.dart';
import 'package:news_shower/data/source/remote/api_key_interceptor.dart';
import 'package:news_shower/data/source/remote/dio_factory.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/domain/repository/news_repository.dart';

abstract final class AppInjector {
  static final GetIt _getIt = GetIt.instance();

  static void init() {
    _registerData();
    _registerDomain();
  }

  static T resolve<T extends Object>() => _getIt<T>();

  static void _registerData() {
    _getIt.registerLazySingleton<ApiKeyInterceptor>(() => ApiKeyInterceptor());
    _getIt.registerLazySingleton<Dio>(() => DioFactory(_getIt()).create());
    _getIt.registerLazySingleton<NewsApi>(() => NewsApi(_getIt()));
  }

  static void _registerDomain() {
    _getIt.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(_getIt()),
    );
  }
}
