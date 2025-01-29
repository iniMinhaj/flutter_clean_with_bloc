// domain/repositories/auth_repository.dart
import 'package:flutter_clean_with_bloc/features/auth/data/mapper/model_to_entity.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDatasource.login(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) {
return Left(Failure(message: failure.message));

      }, // Propagate the failure
      (userModel) {
        // Convert UserModel to UserEntity using the mapper
        final userEntity = UserMapper.toEntity(userModel);
        return Right(userEntity);
      },
    );
  }
}