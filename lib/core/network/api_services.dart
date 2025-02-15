import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/core/error/exception.dart';
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
  Future<Response> get(
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
      return response;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  // POST request
  Future< Response> post({
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
      return response;
    } on DioException catch (err) {
      // Extract error message from `err.error`
      final String errorMessage =
          err.error is String ? err.error.toString() : "Something went wrong.";

      print("API Service Error: $errorMessage"); // Debugging log

      throw ServerException(message: errorMessage);
    }
  }

  // PUT request
  Future<Response> put({
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
      return response;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'An error occurred');
    } catch (e) {
       throw ServerException(message: e.toString() );
    }
  }

  // DELETE request
  Future< Response> delete({
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
      return response;
    } on DioException catch (e) {
       throw ServerException(message: e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(message: e.toString() );
    }
  }

  // File Upload (Multipart request)
  Future<Response> uploadFile({
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
      return response;
    } on DioException catch (e) {
       throw ServerException(message: e.message ?? 'An error occurred');
    } catch (e) {
       throw ServerException(message: e.toString());
    }
  }

  // File Download
  Future<Response> downloadFile({
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
      return response;
    } on DioException catch (e) {
       throw ServerException(message: e.message ?? 'An error occurred');
    } catch (e) {
       throw ServerException(message: e.toString() );
    }
  }
}