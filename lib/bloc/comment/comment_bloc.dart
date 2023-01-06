// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_import
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/response/response.dart';

import 'package:post_media_social/models/comment_post.dart';
import 'package:post_media_social/services/repositories/comment_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepoImpl cmtRepo;
  CommentBloc({required this.cmtRepo}) : super(CommentInitial()) {
    on<LoadCommentEvent>(_onLoadComment);
    on<AddCommentEvent>(_onAddComment);
    on<CommentPostEvent>(_onCommentPost);
  }

  FutureOr<void> _onLoadComment(
      LoadCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    try {
      final result = await cmtRepo.fetchComment(event.postId);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            AppSnackbar.showMessage("NO INTERNET");
          } else if (left is ServerFailure) {
            AppSnackbar.showMessage("SERVER ERROR");
          }
        },
        (DataResponse<List<CommentModel>> dataResponse) {
          switch (dataResponse.statusCode) {
            case 200:
              if (dataResponse.data.isNotEmpty) {
                emit(
                  CommentLoadSuccessfulState(
                    list: dataResponse.data,
                  ),
                );
              } else {
                emit(CommentDataEmptyState());
              }
              break;
            case 201:
              AppSnackbar.showMessage("Error from server");
              break;
            case 400:
              AppSnackbar.showMessage(badRequest);
              break;
            case 401:
              AppSnackbar.showMessage(unauthorized);
              break;
            case 500:
              AppSnackbar.showMessage(serverError);
              break;
            default:
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(CommentErorfulState(message: e.toString()));
    }
  }

  FutureOr<void> _onAddComment(
      AddCommentEvent event, Emitter<CommentState> emit) {
    final state = this.state;
    if (state is CommentLoadSuccessfulState) {
      emit(
        CommentLoadSuccessfulState(
          list: List<CommentModel>.from(state.list)
            ..insert(0, event.commentModel),
          isLoading: false,
        ),
      );
    }
  }

  FutureOr<void> _onCommentPost(
      CommentPostEvent event, Emitter<CommentState> emit) async {
    final state = this.state;
    if (state is CommentLoadSuccessfulState) {
      emit(state.copyWith(isLoading: true));
    }

    try {
      final result = await cmtRepo.commentPost(event.postId, event.message);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            AppSnackbar.showMessage("NO INTERNET");
          } else if (left is ServerFailure) {
            AppSnackbar.showMessage("SERVER ERROR");
          }
        },
        (DataResponse<String> dataResponse) {
          switch (dataResponse.statusCode) {
            case 200:
              AppSnackbar.showMessage("Comment post successful");
              break;
            case 201:
              AppSnackbar.showMessage("Error from server");
              break;
            case 400:
              AppSnackbar.showMessage(badRequest);
              break;
            case 401:
              AppSnackbar.showMessage(unauthorized);
              break;
            case 500:
              AppSnackbar.showMessage(serverError);
              break;
            default:
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
