import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_shower/data/repository/news_repository_impl.dart';
import 'package:news_shower/data/source/remote/api_key_interceptor.dart';
import 'package:news_shower/data/source/remote/dio_factory.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/main/controller/news_list_controller.dart';

abstract final class AppInjector {
  static final GetIt _getIt = GetIt.instance();

  static void init() {
    _registerData();
    _registerDomain();
    _registerUi();
  }

  static T resolve<T extends Object>({dynamic param1, dynamic param2}) =>
      _getIt<T>(param1: param1, param2: param2);

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

  static void _registerUi() {
    _getIt.registerFactoryParam<NewsController, String, void>(
      ((query, _) => NewsController(_getIt(), query)),
    );
  }
}
