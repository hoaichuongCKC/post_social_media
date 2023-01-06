part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikePostEvent extends LikeEvent {
  final int postId;

  const LikePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class UnLikePostEvent extends LikeEvent {
  final int postId;

  const UnLikePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
