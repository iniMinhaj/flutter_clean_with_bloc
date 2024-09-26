import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_clean_with_bloc/features/auth/domain/usecases/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc(this.loginUsecase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await loginUsecase(
          LoginParams(email: event.email, password: event.password));

      result.fold((error) {
        return emit(LoginFailure(error.message));
      }, (userData) {
        return emit(LoginSuccess(userData));
      });
    });
  }
}
