part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
