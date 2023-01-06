// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadSucessfulState extends NotificationState {
  final List<NotificationModel> listToday;
  final List<NotificationModel> listWeek;
  final bool isFirstBuild;
  const NotificationLoadSucessfulState({
    required this.listToday,
    required this.isFirstBuild,
    required this.listWeek,
  });
  @override
  List<Object> get props => [listToday, listWeek, isFirstBuild];

  NotificationLoadSucessfulState copyWith({
    List<NotificationModel>? listToday,
    List<NotificationModel>? listWeek,
    bool? isFirstBuild,
  }) {
    return NotificationLoadSucessfulState(
      listToday: listToday ?? this.listToday,
      listWeek: listWeek ?? this.listWeek,
      isFirstBuild: isFirstBuild ?? this.isFirstBuild,
    );
  }
}

class NotificationLoadErrorState extends NotificationState {
  final String message;
  const NotificationLoadErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class NotificationDataEmptyState extends NotificationState {}
