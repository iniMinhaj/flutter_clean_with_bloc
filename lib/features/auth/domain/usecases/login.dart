// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/repository/auth_repository.dart';

import '../entity/user_entity.dart';

class LoginUsecase implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.login(
        email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
