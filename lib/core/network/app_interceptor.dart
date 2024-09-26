// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_storage/get_storage.dart';

// class ApiInterceptor extends Interceptor {
//   final GetStorage _storage;

//   ApiInterceptor(this._storage);

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options.extra['requiresToken'] == true) {
//       String? token = await _getToken();
//       if (token != null) {
//         options.headers['Authorization'] = 'Bearer $token';
//         options.headers['x-api-key'] = ApiEndpoints.licneseCode;
//       }
//     }
//     handler.next(options); // Proceed with the request
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response); // Proceed with the response
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     print("error = $err");
//     // Handle no internet connection
//     if (err.type == DioExceptionType.connectionTimeout ||
//         err.type == DioExceptionType.unknown) {
//       _showErrorDialog("No internet connection. Please check your network.");
//     }
//     // Handle API-specific error responses
//     else if (err.type == DioExceptionType.badResponse) {
//       int? statusCode = err.response?.statusCode;
//       print("status code: $statusCode");
//       switch (statusCode) {
//         case 401:
//           _showErrorDialog("Unauthorized. Please log in.");
//           break;
//         case 404:
//           _showErrorDialog("Resource not found.");
//           break;
//         case 500:
//           _showErrorDialog("Server error. Please try again later.");
//           break;
//         default:
//           String? apiErrorMessage = err.response?.data['error'];
//           _showErrorDialog(apiErrorMessage != null && apiErrorMessage.isNotEmpty
//               ? apiErrorMessage
//               : "An unknown error occurred.");
//       }
//     } else {
//       _showErrorDialog("Something went wrong. Please try again.");
//     }
//     handler.next(err); // Pass through the error
//   }

//   Future<String?> _getToken() async {
//     return _storage.read('token'); // Retrieve token from local storage
//   }

//   void _showErrorDialog(String message) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class ApiInterceptor extends Interceptor {
  final GetStorage _storage;

  ApiInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['requiresToken'] == true) {
      String? token = await _getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['x-api-key'] = ApiEndpoints.licneseCode;

    handler.next(options); // Proceed with the request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response); // Proceed with the response
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("error = $err");
    // Handle no internet connection
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.unknown) {
      _showErrorDialog("No internet connection. Please check your network.");
    }
    // Handle API-specific error responses
    else if (err.type == DioExceptionType.badResponse) {
      int? statusCode = err.response?.statusCode;
      print("status code: $statusCode");

      switch (statusCode) {
        case 400:
          print("400 error = ${err.response}");
          _handleValidationErrors(err.response?.data);
          break;
        case 401:
          _showErrorDialog("Unauthorized. Please log in.");
          break;
        case 404:
          _showErrorDialog("Resource not found.");
          break;
        case 500:
          _showErrorDialog("Server error. Please try again later.");
          break;
        default:
          String? apiErrorMessage = err.response?.data['error'];
          print("Defaul error = $apiErrorMessage");
          _showErrorDialog(apiErrorMessage != null && apiErrorMessage.isNotEmpty
              ? apiErrorMessage
              : "An unknown error occurred.");
      }
    } else {
      _showErrorDialog("Something went wrong. Please try again.");
    }
    return handler.next(err); // Pass through the error
  }

  Future<String?> _getToken() async {
    return _storage.read('token'); // Retrieve token from local storage
  }

  void _showErrorDialog(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Handle 400 Validation Errors
  void _handleValidationErrors(Map<String, dynamic>? errorData) {
    print("validation error = $errorData");
    if (errorData != null && errorData['errors'] != null) {
      Map<String, dynamic> errors = errorData['errors'];
      String errorMessage = '';
      errors.forEach((field, messages) {
        errorMessage += '${messages.join(', ')}\n';
      });
      _showErrorDialog(errorMessage.trim());
    } else {
      _showErrorDialog("An unknown validation error occurred.");
    }
  }
}
