// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CheckData extends UserEvent {}

class ChangeBackground extends UserEvent {
  final File file;
  const ChangeBackground({required this.file});
  @override
  List<Object> get props => [file];
}

class ChangeAvatar extends UserEvent {
  final File file;
  const ChangeAvatar({required this.file});
  @override
  List<Object> get props => [file];
}
