// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepoImpl authRepoImpl;
  RegisterBloc({required this.authRepoImpl}) : super(RegisterInitial()) {
    on<SubmitRegisterEvent>(_handleRegister);
  }

  FutureOr<void> _handleRegister(
      SubmitRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      final result = await authRepoImpl.register(SubmitRegisterEvent(
          username: event.username,
          displayName: event.displayName,
          phone: event.phone,
          password: event.password,
          image: event.image));
      result.fold(
        (left) {
          if (left is InternetFailure) {
            emit(const RegisterErrorState(message: "NO INTERNET"));
          } else if (left is ServerFailure) {
            emit(const RegisterErrorState(message: "SERVER ERROR"));
          }
        },
        (bodyResponse) async {
          //handle get data
          switch (bodyResponse.statusCode) {
            case 200:
              emit(RegisterSuccessState());

              final hive = UserHive(
                id: bodyResponse.user.id,
                accessToken: bodyResponse.accessToken,
                tokenType: bodyResponse.tokenType,
                displayName: bodyResponse.user.displayName,
                avatar: bodyResponse.user.avatar,
                imageBackground: bodyResponse.user.imageBackground,
              );
              await BoxUser.instance.setData(hive);
              break;
            case 201:
              emit(RegisterErrorState(message: bodyResponse.message));
              break;
            case 400:
              emit(const RegisterErrorState(message: "BAD REQUEST"));
              break;
            case 401:
              emit(const RegisterErrorState(message: "UNAUTHOIRES"));
              break;
            case 500:
              emit(const RegisterErrorState(message: "SERVER ERROR"));
              break;
            default:
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(RegisterErrorState(message: e.toString()));
    }
  }
}
