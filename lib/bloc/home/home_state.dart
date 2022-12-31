// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessfulState extends HomeState {
  final List<PostModel> listPost;
  final bool hasFirstPost;
  final LoadMore stateLoad;
  const HomeSuccessfulState({
    required this.listPost,
    required this.hasFirstPost,
    this.stateLoad = const LoadDataInit(),
  });
  @override
  List<Object> get props => [listPost, hasFirstPost, stateLoad];
}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

abstract class LoadMore {
  const LoadMore();
}

class LoadDataInit extends LoadMore {
  const LoadDataInit();
}

class LoadingMoreData extends LoadMore {}

class SuccessfulMoreData extends LoadMore {}

class LoadDataEmtpy extends LoadMore {}
