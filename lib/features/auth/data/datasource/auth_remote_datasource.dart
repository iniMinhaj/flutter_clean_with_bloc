import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/network/api_services.dart';
import '../../../../core/error/exception.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiService apiService;

  AuthRemoteDatasourceImpl({required this.apiService});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    print("Login started");
    print("Email: $email");
    print("Password: $password");

    try {
      // Call the API
      final response = await apiService.post(
        endpoint: ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      // If it's a Response, process the response

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 201) {
        // Parse the response into a UserModel

        final userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        throw ServerException(message: 'Failed to load user data');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'An error occurred');
    }
  }
}
