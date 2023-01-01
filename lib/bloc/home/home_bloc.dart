// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/post.dart';
import 'package:post_media_social/services/repositories/post_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepoImpl postRepoImpl;
  HomeBloc({required this.postRepoImpl}) : super(HomeInitial()) {
    on<LoadPostEvent>(_handleLoadPost);
    on<LoadMorePostEvent>(_handleLoadMorePost);
    on<AddNewPostEvent>(_onAddNewPost);
    on<OnRefreshDataEvent>((event, emit) {
      final state = this.state;
      if (state is HomeSuccessfulState) {
        state.listPost.clear();
      }
      add(LoadPostEvent(page: event.page, limit: event.limit));
    });
  }

  FutureOr<void> _handleLoadPost(
      LoadPostEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    if (state is HomeInitial) {
      emit(HomeLoadingState());
    }

    try {
      final result = await postRepoImpl.getListPost(event.page, event.limit);

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
              emit(HomeSuccessfulState(
                  listPost: dataResponse.data, hasLoadMore: true));
              break;
            case 201:
              emit(const HomeErrorState(message: "I don't know anything"));
              break;
            case 400:
              emit(const HomeErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const HomeErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const HomeErrorState(message: "SERVER ERROR"));
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
    final result = await postRepoImpl.getListPost(event.page, event.limit);

    result.fold(
      (left) {
        if (left is InternetFailure) {
        } else if (left is ServerFailure) {}
      },
      (DataResponse<List<PostModel>> dataResponse) {
        if (dataResponse.statusCode == 200) {
          if (state is HomeSuccessfulState) {
            if (dataResponse.data.isEmpty) {
              emit(
                HomeSuccessfulState(
                    listPost: state.listPost,
                    hasLoadMore: false,
                    stateLoad: LoadDataEmtpy()),
              );
            } else {
              emit(
                HomeSuccessfulState(
                    listPost: List<PostModel>.from(state.listPost)
                      ..addAll(dataResponse.data),
                    hasLoadMore: false,
                    stateLoad: SuccessfulMoreData()),
              );
            }
          }
        }
      },
    );
  }

  Future<void> _onAddNewPost(
      AddNewPostEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    if (state is HomeSuccessfulState) {
      final postMap = jsonDecode(event.post)["data"];

      final postModel = PostModel.fromJson(postMap);

      emit(HomeSuccessfulState(
          listPost: List<PostModel>.from(state.listPost)..insert(0, postModel),
          hasLoadMore: false));
    }
  }
}
