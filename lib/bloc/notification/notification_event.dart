// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNoticationEvent extends NotificationEvent {}

class AddNotiTodayEvent extends NotificationEvent {
  final dynamic noti;
  const AddNotiTodayEvent({
    required this.noti,
  });
  @override
  List<Object> get props => [noti];
}
