// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

class AuthChangeState extends AuthState {
  final String username;
  final String password;
  const AuthChangeState({this.username = '', this.password = ''});

  @override
  List<Object> get props => [username, password];

  AuthChangeState copyWith({
    String? username,
    String? password,
  }) {
    return AuthChangeState(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState({
    required this.message,
  });
}

class AuthSuccessState extends AuthState {}
