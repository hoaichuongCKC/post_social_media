// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_post_bloc.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object> get props => [];
}

class SubmitPostEvent extends UploadPostEvent {
  final String content;
  final List<File> file;
  const SubmitPostEvent({
    required this.content,
    required this.file,
  });
  @override
  List<Object> get props => [file, content];
}
