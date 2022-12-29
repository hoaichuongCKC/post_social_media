// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SubmitRegisterEvent extends RegisterEvent {
  final String username;
  final String displayName;
  final String password;
  final String phone;
  final File image;
  const SubmitRegisterEvent({
    required this.username,
    required this.displayName,
    required this.phone,
    required this.password,
    required this.image,
  });
  @override
  List<Object> get props => [username, phone, displayName, password, image];
}
