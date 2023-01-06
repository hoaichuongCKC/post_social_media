// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/services/repositories/post_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepoImpl postRepoImpl;
  HomeBloc({required this.postRepoImpl}) : super(HomeInitial()) {
    on<LoadPostEvent>(_handleLoadPost);
    on<LoadMorePostEvent>(_handleLoadMorePost);
    on<AddNewPostEvent>(_onAddNewPost);
    on<DeletePostEvent>(_onDeletePost);
    on<OnRefreshDataEvent>((event, emit) {
      final state = this.state;
      if (state is HomeSuccessfulState) {
        state.listPost.clear();
        state.listBuild.clear();
      }

      add(LoadPostEvent());
    });
  }

  FutureOr<void> _handleLoadPost(
      LoadPostEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final result = await postRepoImpl.getListPost();

      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const HomeErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const HomeErrorState(message: "SERVER ERROR"));
          }
        },
        (DataResponse<List<PostModel>> dataResponse) {
          switch (dataResponse.statusCode) {
            case 200:
              emit(
                HomeSuccessfulState(
                  listPost: dataResponse.data,
                  isLoadMore: true,
                  stateLoad: const LoadDataInit(),
                  listBuild: dataResponse.data.skip(0).take(5).toList(),
                ),
              );

              break;
            case 201:
              emit(const HomeErrorState(message: "I don't know anything"));
              break;
            case 400:
              emit(const HomeErrorState(message: badRequest));
              break;
            case 401:
              emit(const HomeErrorState(message: unauthorized));
              break;
            case 500:
              emit(const HomeErrorState(message: serverError));
              break;
            case 502:
              AppSnackbar.showMessage("BAD GATEWAY");
              break;
            default:
          }
        },
      );
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _handleLoadMorePost(
      LoadMorePostEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    final currentGetPage = event.page * event.limit;
    if (state is HomeSuccessfulState) {
      final listMore = List<PostModel>.from(state.listPost)
          .skip(currentGetPage)
          .take(event.limit)
          .toList();

      if (listMore.isEmpty) {
        emit(state.copyWith(isLoadMore: false, stateLoad: LoadDataEmtpy()));
      } else {
        emit(state.copyWith(
            listBuild: List<PostModel>.from(state.listBuild)..addAll(listMore),
            isLoadMore: false,
            stateLoad: SuccessfulMoreData()));
      }
    }
  }

  Future<void> _onAddNewPost(
      AddNewPostEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    if (state is HomeSuccessfulState) {
      final postMap = jsonDecode(event.post)["data"];

      final postModel = PostModel.fromJson(postMap);
      emit(state.copyWith(
        listBuild: List<PostModel>.from(state.listBuild)..insert(0, postModel),
        isLoadMore: false,
      ));
    }
  }

  FutureOr<void> _onDeletePost(
      DeletePostEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    if (state is HomeSuccessfulState) {
      AppSnackbar.showMessage("Deleted Successful");
      emit(state.copyWith(
        listBuild: List<PostModel>.from(state.listBuild)..removeAt(event.index),
        isLoadMore: false,
      ));
    }
    try {
      final result = await postRepoImpl.deletePost(event.postId);
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
      AppSnackbar.showMessage(e.toString());
      debugPrint(e.toString());
    }
  }
}
