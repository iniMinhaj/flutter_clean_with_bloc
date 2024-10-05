import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/repository/auth_repo_impl.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/usecases/login.dart';
import 'package:flutter_clean_with_bloc/features/product/data/datasource/product_remote_datasource.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/usecase/get_product.dart';
import 'package:flutter_clean_with_bloc/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'core/network/api_services.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/data/repository/product_repo_impl.dart';
import 'features/product/domain/respository/product_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  _registerExternalDependencies();

  // Core services
  _registerCoreServices();

  // Data sources
  _registerDataSources();

  // Repositories
  _registerRepositories();

  // Use cases
  _registerUseCases();

  // Blocs / Cubits
  _registerBlocs();
}

void _registerExternalDependencies() {
  sl.registerLazySingleton(() => Dio()); // Optionally, add configurations here
  sl.registerLazySingleton(() => GetStorage());
}

void _registerCoreServices() {
  sl.registerLazySingleton(() => ApiService(dio: sl<Dio>()));
}

void _registerDataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiService: sl<ApiService>()),
  );
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(apiService: sl<ApiService>()),
  );
}

void _registerRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: sl<AuthRemoteDatasource>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productRemoteDatasource: sl<ProductRemoteDatasource>()),
  );
}

void _registerUseCases() {
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetProductUsecase(productRepository: sl<ProductRepository>()));
}

void _registerBlocs() {
  sl.registerFactory(() => AuthBloc(sl<LoginUsecase>()));
  sl.registerFactory(() => ProductBloc(getProductUsecase: sl<GetProductUsecase>()));
}
