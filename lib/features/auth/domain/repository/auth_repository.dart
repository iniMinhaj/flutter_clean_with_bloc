import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password});
}
