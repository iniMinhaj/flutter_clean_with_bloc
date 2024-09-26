import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_clean_with_bloc/features/auth/data/mapper/model_to_entity.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final userModel =
          await authRemoteDatasource.login(email: email, password: password);
      final user = UserMapper.userModelToEntity(userModel);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
