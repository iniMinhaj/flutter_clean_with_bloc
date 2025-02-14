/* syntax: sl.registerLazySingleton<AbstractType>(() => ConcreteImplementation()); */

import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/repository/auth_repo_impl.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/usecases/login.dart';
import 'package:flutter_clean_with_bloc/features/home/data/datasources/home_data_source.dart';
import 'package:flutter_clean_with_bloc/features/home/data/repository/home_repo_impl.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/usecases/home_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'core/network/api_services.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => GetStorage());

  // ApiService
  sl.registerLazySingleton(() => ApiService(dio: sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiService: sl<ApiService>()),
  );
  sl.registerLazySingleton<HomeDataSource>(()=> HomeDataSourceImpl(apiService: sl<ApiService>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: sl<AuthRemoteDatasource>()),
  );
  sl.registerLazySingleton<HomeRepository>(()=> HomeRepositoryImpl(homeDataSource: sl<HomeDataSource>()));

  // Use cases
  sl.registerLazySingleton(
      () => LoginUsecase(repository: sl<AuthRepository>()));
  sl.registerLazySingleton(
      () => HomeUsecase(repository: sl<HomeRepository>()));

  // Blocs / Cubits
  sl.registerFactory(() => AuthBloc(loginUsecase:  sl<LoginUsecase>()));
  sl.registerFactory(() => HomeBloc(homeUsecase:   sl<HomeUsecase>()));
}
