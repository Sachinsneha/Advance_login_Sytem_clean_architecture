part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSingUp extends AuthEvent {
  final String email;
  final String name;
  final String password;

  const AuthSingUp({
    required this.email,
    required this.name,
    required this.password,
  });
}

final class AuthLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthLogIn({
    required this.email,
    required this.password,
  });
}

final class CurrentUserLogedIn extends AuthEvent {}
