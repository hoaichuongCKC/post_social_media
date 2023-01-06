// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/services/repositories/like_repo.dart';
part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeRepoImpl likeRepoImpl;
  LikeBloc({required this.likeRepoImpl}) : super(LikeInitial()) {
    on<LikePostEvent>(_onLikePost);
    on<UnLikePostEvent>(_onUnLikePost);
  }

  FutureOr<void> _onLikePost(
      LikePostEvent event, Emitter<LikeState> emit) async {
    try {
      final result = await likeRepoImpl.likePost(event.postId);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(LikeErrorState());

            AppSnackbar.showMessage("Invalid Internet....");
          } else if (left is ServerFailure) {
            emit(LikeErrorState());

            AppSnackbar.showMessage("Server error....");
          }
        },
        (right) {
          log(right.data);
          if (right.statusCode == 200) {
            emit(StatusLikeState(stateLike: LikedPost()));
          } else {
            emit(LikeErrorState());
            AppSnackbar.showMessage("....");
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(LikeErrorState());
    }
  }

  FutureOr<void> _onUnLikePost(
      UnLikePostEvent event, Emitter<LikeState> emit) async {
    print("unliked");
    // try {
    //   final result = await likeRepoImpl.likePost(event.postId);
    //   result.fold(
    //     (left) {
    //       if (left is InternetFailure) {
    //         emit(LikeErrorState());

    //         AppSnackbar.showMessage("Invalid Internet....");
    //       } else if (left is ServerFailure) {
    //         emit(LikeErrorState());

    //         AppSnackbar.showMessage("Server error....");
    //       }
    //     },
    //     (right) {},
    //   );
    // } catch (e) {
    //   emit(LikeErrorState());
    // }
  }
}
