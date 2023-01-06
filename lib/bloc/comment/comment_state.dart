// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadSuccessfulState extends CommentState {
  final List<CommentModel> list;
  final bool isLoading;

  const CommentLoadSuccessfulState({
    required this.list,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [list, isLoading];

  CommentLoadSuccessfulState copyWith({
    List<CommentModel>? list,
    bool? isLoading,
  }) {
    return CommentLoadSuccessfulState(
      list: list ?? this.list,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CommentDataEmptyState extends CommentState {}

class CommentErorfulState extends CommentState {
  final String message;
  const CommentErorfulState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
