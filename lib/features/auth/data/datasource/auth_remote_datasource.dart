import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/core/network/api_services.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiService apiService;

  AuthRemoteDatasourceImpl({required this.apiService});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    print("Login started");
    print("Email: $email");
    print("Password: $password");

    // Call the API
    final result = await apiService.post(
      endpoint: ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    // Handle the result using fold
    return result.fold(
      // If it's a Failure, return Left(Failure)
      (failure) {
        print("Login failed: ${failure.message}");
        return Left(failure);
      },
      // If it's a Response, process the response
      (response) {
        print("Response status code: ${response.statusCode}");
        print("Response data: ${response.data}");

        if (response.statusCode == 201) {
          // Parse the response into a UserModel
          try {
            final userModel = UserModel.fromJson(response.data);
            return Right(userModel);
          } catch (e) {
            print("Failed to parse UserModel: $e");
            return Left(ServerFailure(message: 'Failed to parse response'));
          }
        } else {
          // Handle API-specific errors (e.g., 400, 401, 500)
          final errorMessage = response.data['message'] ?? 'An unknown error occurred';
          return Left(ServerFailure(message: errorMessage));
        }
      },
    );
  }
}