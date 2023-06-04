import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:recepify/core/network/network_info.dart';
import 'package:recepify/features/category_list/data/datasources/category_list_remote_data_source.dart';
import 'package:recepify/features/category_list/data/repositories/category_list_repository_impl.dart';
import 'package:recepify/features/category_list/domain/repositories/category_list_repository.dart';
import 'package:recepify/features/category_list/domain/usecases/get_category_list.dart';
import 'package:recepify/features/category_list/presentation/bloc/category_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/category_list/data/datasources/category_list_local_data_source.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => CategoryListBloc(getCategoryList: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetCategoryList(sl()));
  // Repository
  sl.registerLazySingleton<CategoryListRepository>(() =>
      CategoryListRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  // Data sources
  sl.registerLazySingleton<CategoryListRemoteDataSource>(
      () => CategoryListRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryListLocalDataSource>(
      () => CategoryListLocalDataSourceImpl(sharedPreferences: sl()));
  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External
  const sharedPreferences = SharedPreferences.getInstance;
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
