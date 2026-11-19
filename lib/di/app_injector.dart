import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_shower/common/domain/external_browser_link_launcher.dart';
import 'package:news_shower/common/domain/link_launcher.dart';
import 'package:news_shower/data/repository/news_repository_impl.dart';
import 'package:news_shower/data/source/remote/api_key_interceptor.dart';
import 'package:news_shower/data/source/remote/dio_factory.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/data/source/remote/news_api_impl.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';

abstract final class AppInjector {
  static final GetIt _getIt = GetIt.instance;

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
    _getIt.registerLazySingleton<NewsApi>(() => NewsApiImpl(_getIt()));
  }

  static void _registerDomain() {
    _getIt.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(_getIt()),
    );
    _getIt.registerLazySingleton<LinkLauncher>(
      () => ExternalBrowserLinkLauncher(),
    );
  }

  static void _registerUi() {
    _getIt.registerFactoryParam<NewsListController, String, void>(
      ((query, _) => NewsListController(_getIt(), _getIt(), query)),
    );

    _getIt.registerFactory<NewsSearchController>(() => NewsSearchController());
  }
}
