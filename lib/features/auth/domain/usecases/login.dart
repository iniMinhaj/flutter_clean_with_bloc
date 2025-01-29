// domain/usecases/login_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}