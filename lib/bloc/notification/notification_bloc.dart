// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/notification.dart';
import '../../services/repositories/noti_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotiRepoImpl notiRepoImpl;
  NotificationBloc({required this.notiRepoImpl})
      : super(NotificationInitial()) {
    on<LoadNoticationEvent>(_onLoadNoti);
    on<AddNotiTodayEvent>(_onAddNotiToday);
  }

  FutureOr<void> _onLoadNoti(
      LoadNoticationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());
    try {
      final result = await notiRepoImpl.getNoti();
      result.fold(
        (left) {
          if (left is InternetFailure) {
            AppSnackbar.showMessage("NO INTERNET");
          } else if (left is ServerFailure) {
            AppSnackbar.showMessage("SERVER ERROR");
          }
        },
        (DataResponse<List<NotificationModel>> dataResponse) {
          switch (dataResponse.statusCode) {
            case 200:
              if (dataResponse.data.isNotEmpty) {
                emit(
                  NotificationLoadSucessfulState(
                    isFirstBuild: true,
                    listToday: dataResponse.data
                        .where((element) =>
                            element.created_at.toIso8601String().checkToday())
                        .toList(),
                    listWeek: dataResponse.data
                        .where((element) =>
                            !element.created_at.toIso8601String().checkToday())
                        .toList(),
                  ),
                );
              } else {
                emit(NotificationDataEmptyState());
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
      debugPrint("Error from notification-bloc: ${e.toString()}");
      emit(NotificationLoadErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onAddNotiToday(
      AddNotiTodayEvent event, Emitter<NotificationState> emit) {
    final state = this.state;
    if (state is NotificationLoadSucessfulState) {
      final NotificationModel noti =
          NotificationModel.fromJson(jsonDecode(event.noti)["data"]);
      emit(state.copyWith(
          isFirstBuild: false,
          listToday: List<NotificationModel>.from(state.listToday)
            ..insert(0, noti)));
    }
  }
}
