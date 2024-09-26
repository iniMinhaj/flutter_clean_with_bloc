import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/error/exception.dart';
import 'package:flutter_clean_with_bloc/main.dart';

import '../../../../core/network/api_services.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiService apiService;

  AuthRemoteDatasourceImpl({required this.apiService});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    print("login is started");
    print("email = ${email}");
    print("password = ${password}");
    final response = await apiService.post(endpoint: ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });

    print("response = ${response.data}");

    if (response.statusCode == 201) {
      storage.write('token', response.data['token']);
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(message: response.data['message']);
    }
  }
}
