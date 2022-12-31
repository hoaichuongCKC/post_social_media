// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/services/repositories/post_repo.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  final PostRepoImpl postRepoImpl;

  UploadPostBloc({required this.postRepoImpl}) : super(UploadPostInitial()) {
    on<SubmitPostEvent>((event, emit) async {
      emit(UploadingPostState());

      try {
        final result = await postRepoImpl.createPost(event.content, event.file);
        result.fold((left) {
          if (left is InternetFailure) {
            emit(const UploadPostErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const UploadPostErrorState(message: "SERVER ERROR"));
          }
        }, (bodyResponse) async {
          //handle get data
          switch (bodyResponse.statusCode) {
            case 200:
              emit(UploadPostSuccessfulState(message: bodyResponse.data));
              break;
            case 201:
              emit(UploadPostErrorState(message: bodyResponse.data));
              break;
            case 400:
              emit(const UploadPostErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const UploadPostErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const UploadPostErrorState(message: "SERVER ERROR"));
              break;
            default:
          }
        });
      } catch (e) {
        emit(UploadPostErrorState(message: e.toString()));
      }
    });
  }
}
