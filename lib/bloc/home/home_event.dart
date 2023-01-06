// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadPostEvent extends HomeEvent {}

class LoadMorePostEvent extends HomeEvent {
  final int page;
  final int limit;
  const LoadMorePostEvent({
    required this.page,
    required this.limit,
  });
  @override
  List<Object> get props => [page, limit];
}

class OnRefreshDataEvent extends HomeEvent {
  final int page;
  final int limit;
  const OnRefreshDataEvent({
    required this.page,
    required this.limit,
  });
  @override
  List<Object> get props => [page, limit];
}

class AddNewPostEvent extends HomeEvent {
  final dynamic post;

  const AddNewPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends HomeEvent {
  final int postId;
  final int index;

  const DeletePostEvent({required this.postId, required this.index});

  @override
  List<Object> get props => [postId, index];
}
