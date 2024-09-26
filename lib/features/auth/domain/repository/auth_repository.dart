import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
}
