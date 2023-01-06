// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'like_bloc.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

class LikeInitial extends LikeState {}

class StatusLikeState extends LikeState {
  final StatusLike stateLike;

  const StatusLikeState({this.stateLike = const InitStatusLike()});

  StatusLikeState copyWith({
    StatusLike? stateLike,
  }) {
    return StatusLikeState(
      stateLike: stateLike ?? this.stateLike,
    );
  }

  @override
  List<Object> get props => [stateLike];
}

class LikeErrorState extends LikeState {}

abstract class StatusLike {
  const StatusLike();
}

class InitStatusLike extends StatusLike {
  const InitStatusLike();
}

class LikedPost extends StatusLike {}

class UnlikedPost extends StatusLike {}
