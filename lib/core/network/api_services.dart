import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../error/failures.dart'; // Define your Failure class
import 'app_interceptor.dart';
 

class ApiService {
  final Dio _dio;
  final GetStorage _storage;

  ApiService({required Dio dio})
      : _dio = dio,
        _storage = GetStorage() {
    _dio.interceptors.add(ApiInterceptor(_storage));
  }

  // GET request
  Future<Either<Failure, Response>> get(
    {required String endpoint, 
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unknown error occurred'));
    }
  }

  // POST request
  Future<Either<Failure, Response>> post({
    required String endpoint,
    Map<String,dynamic>? data,
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (err) {
      // Extract error message from `err.error`
      final String errorMessage =
          err.error is String ? err.error.toString() : "Something went wrong.";

      print("API Service Error: $errorMessage"); // Debugging log

      return Left(ServerFailure(message:  errorMessage));
    }
  }

  // PUT request
  Future<Either<Failure, Response>> put({
    required String endpoint,
    dynamic data,
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unknown error occurred'));
    }
  }

  // DELETE request
  Future<Either<Failure, Response>> delete({
    required String endpoint,
    dynamic data,
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unknown error occurred'));
    }
  }

  // File Upload (Multipart request)
  Future<Either<Failure, Response>> uploadFile({
    required String endpoint,
    required FormData formData,
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unknown error occurred'));
    }
  }

  // File Download
  Future<Either<Failure, Response>> downloadFile({
    required String url,
    required String savePath,
    bool requiresToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        options: Options(extra: {'requiresToken': requiresToken}),
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unknown error occurred'));
    }
  }
}