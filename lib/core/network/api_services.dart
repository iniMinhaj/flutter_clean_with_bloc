import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'app_interceptor.dart';

class ApiService {
  final Dio _dio;
  final GetStorage _storage;

  ApiService({required Dio dio})
      : _dio = dio,
        _storage = GetStorage() {
    _dio.interceptors.add(ApiInterceptor(_storage));
  }

  // Example GET request method
  Future<Response> get({required String endpoint, bool requiresToken = false}) async {
    return await _dio.get(endpoint,
        options: Options(extra: {'requiresToken': requiresToken}));
  }

  // Example POST request method
  Future<Response> post({
    required String endpoint,
    dynamic data,
    bool requiresToken = false,
  }) async {
    return await _dio.post(endpoint,
        data: data,
        options: Options(extra: {
          'requiresToken': requiresToken,
        }));
  }

  // Add other methods for PUT, DELETE similarly...
}
