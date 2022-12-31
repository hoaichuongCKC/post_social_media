// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_post_bloc.dart';

abstract class UploadPostState extends Equatable {
  const UploadPostState();

  @override
  List<Object> get props => [];
}

class UploadPostInitial extends UploadPostState {}

class UploadingPostState extends UploadPostState {}

class UploadPostSuccessfulState extends UploadPostState {
  final String message;

  const UploadPostSuccessfulState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class UploadPostErrorState extends UploadPostState {
  final String message;

  const UploadPostErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
