import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:get_storage/get_storage.dart';

class ApiInterceptor extends Interceptor {
  final GetStorage _storage;

  ApiInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['requiresToken'] == true) {
      String? token =  _storage.read('token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['x-api-key'] = ApiEndpoints.licenseCode;

    handler.next(options); // Proceed with the request
  }


 @override
void onError(DioException err, ErrorInterceptorHandler handler) {
  String errorMessage = _handleError(err);

    DioException newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response, // Keep original response if available
      type: err.type,
      error: errorMessage, // Pass error message here
    );

    print('Error Message on Interceptor = $errorMessage');

    handler.reject(newError);

 
}
  
String _handleError(DioException err) {
  if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
    return "No internet connection.";
  } else if (err.response != null) {
    int? statusCode = err.response?.statusCode;

    switch (statusCode) {
      case 400:
        // Parse validation errors from the response
        final errors = err.response?.data['errors'];
        if (errors is Map<String, dynamic>) {
          return errors.values.join('\n'); // Join all validation messages
        }
        return "Invalid request. Please check your input.";
      case 401:
        return "Unauthorized. Please log in.";
      case 404:
        return "Resource not found.";
      case 422:
        // Parse validation errors from the response
        final errors = err.response?.data['errors'];
        if (errors is Map<String, dynamic>) {
          return errors.values.join('\n'); // Join all validation messages
        }
        return "Validation failed. Please check your input.";
      case 500:
        return "Server error. Please try again later.";
      default:
        return "An unknown error occurred.";
    }
  } else {
    return "Something went wrong.";
  }
}
}
