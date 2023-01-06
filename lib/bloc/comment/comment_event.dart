// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentEvent extends CommentEvent {
  final int postId;

  const LoadCommentEvent({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}

class AddCommentEvent extends CommentEvent {
  final CommentModel commentModel;
  const AddCommentEvent({
    required this.commentModel,
  });
  @override
  List<Object> get props => [commentModel];
}

class CommentPostEvent extends CommentEvent {
  final int postId;
  final String message;
  const CommentPostEvent({
    required this.postId,
    required this.message,
  });
  @override
  List<Object> get props => [postId, message];
}
