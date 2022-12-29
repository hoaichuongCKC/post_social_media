// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthenticated extends UserState {
  const UserAuthenticated();
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UserUnauthorizedState extends UserState {}
