// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepoImpl authRepoImpl;
  AuthBloc({required this.authRepoImpl}) : super(const AuthInitial()) {
    on<SubmitEvent>(_submitEvent);
    on<LogoutUser>(_handleLogout);
  }

  _submitEvent(SubmitEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final result =
          await authRepoImpl.authUser(event.username, event.password);
      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const AuthErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const AuthErrorState(message: "SERVER ERROR"));
          }
        },
        (bodyResponse) async {
          //handle get data
          switch (bodyResponse.statusCode) {
            case 200:
              emit(AuthSuccessState());
              final hive = UserHive(
                id: bodyResponse.user.id,
                accessToken: bodyResponse.accessToken,
                tokenType: bodyResponse.tokenType,
                displayName: bodyResponse.user.displayName,
                username: bodyResponse.user.username,
                avatar: bodyResponse.user.avatar,
                imageBackground: bodyResponse.user.imageBackground,
              );
              await BoxUser.instance.setData(hive);
              break;
            case 201:
              emit(AuthErrorState(message: bodyResponse.message));
              break;
            case 400:
              emit(const AuthErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const AuthErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const AuthErrorState(message: "SERVER ERROR"));
              break;
            default:
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _handleLogout(
      LogoutUser event, Emitter<AuthState> emit) async {
    AppRoutes.pushNameAndRemoveUntil(loginPath);
    try {
      final result = await authRepoImpl.logout();

      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const AuthErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const AuthErrorState(message: "SERVER ERROR"));
          }
        },
        (statusCode) async {
          if (statusCode == 200) {
            emit(const AuthInitial());
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
