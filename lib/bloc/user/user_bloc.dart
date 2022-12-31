// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepoImpl authRepoImpl;
  UserBloc({required this.authRepoImpl}) : super(UserInitialState()) {
    on<CheckData>(_check);
    on<ChangeBackground>(_handleChangeBackground);
    on<ChangeAvatar>(_handleChangeAvatar);
  }

  FutureOr<void> _check(CheckData event, Emitter<UserState> emit) async {
    final checkUser = await BoxUser.instance.getData();
    if (checkUser == null) {
      AppRoutes.pushNameAndRemoveUntil(loginPath);
    } else {
      AppRoutes.pushNameAndRemoveUntil(homePath);
    }
  }

  FutureOr<void> _handleChangeBackground(
      ChangeBackground event, Emitter<UserState> emit) async {
    emit(UploadingState());
    try {
      final result = await authRepoImpl.uploadFile(
          event.file, sl.get<Api>().upload_file_background);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const UploadErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const UploadErrorState(message: "SERVER ERROR"));
          }
        },
        (bodyResponse) async {
          //handle get data
          switch (bodyResponse.statusCode) {
            case 200:
              emit(UploadSuccessfulState());
              await BoxUser.instance.editBackground(bodyResponse.message);
              break;
            case 201:
              emit(const UploadErrorState(message: "Khum biết luôn huhu"));
              break;
            case 400:
              emit(const UploadErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const UploadErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const UploadErrorState(message: "SERVER ERROR"));
              break;
            default:
          }
        },
      );
    } catch (e) {
      emit(UploadErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _handleChangeAvatar(
      ChangeAvatar event, Emitter<UserState> emit) async {
    emit(UploadingState());
    try {
      final result = await authRepoImpl.uploadFile(
          event.file, sl.get<Api>().upload_file_avatar);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const UploadErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const UploadErrorState(message: "SERVER ERROR"));
          }
        },
        (bodyResponse) async {
          //handle get data
          switch (bodyResponse.statusCode) {
            case 200:
              emit(UploadSuccessfulState());
              await BoxUser.instance.editAvatar(bodyResponse.message);
              break;
            case 201:
              emit(const UploadErrorState(message: "Khum biết luôn huhu"));
              break;
            case 400:
              emit(const UploadErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const UploadErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const UploadErrorState(message: "SERVER ERROR"));
              break;
            default:
          }
        },
      );
    } catch (e) {
      emit(UploadErrorState(message: e.toString()));
    }
  }
}
