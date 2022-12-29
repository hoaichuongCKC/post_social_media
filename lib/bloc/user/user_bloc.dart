// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepoImpl authRepoImpl;
  UserBloc({required this.authRepoImpl}) : super(UserInitialState()) {
    on<CheckData>(_check);
  }

  FutureOr<void> _check(CheckData event, Emitter<UserState> emit) async {
    final checkUser = await BoxUser.instance.getData();
    if (checkUser == null) {
      AppRoutes.pushNameAndRemoveUntil(loginPath);
    } else {
      AppRoutes.pushNameAndRemoveUntil(homePath);
    }
  }
}
