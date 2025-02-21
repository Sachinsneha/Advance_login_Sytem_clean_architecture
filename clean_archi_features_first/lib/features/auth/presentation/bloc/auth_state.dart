part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authloading extends AuthState {}

final class AuthFaliure extends AuthState {
  final String message;

  AuthFaliure(this.message);
}

final class AuthSuccess extends AuthState {
  final UserProfile user;
  AuthSuccess(this.user);
}
