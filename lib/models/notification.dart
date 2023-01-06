// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:post_media_social/config/export.dart';
part 'notification.g.dart';

List<NotificationModel> notificationFromJson(String bodyConvert) =>
    List<NotificationModel>.from(
      json.decode(bodyConvert).map((x) {
        return NotificationModel.fromJson(x);
      }),
    );

@JsonSerializable(explicitToJson: true)
class NotificationModel extends Equatable {
  final int id;
  final UserModel user;
  final List<dynamic> post;
  final String nameUserComment;
  final String avatarUserComment;
  final String title;
  final DateTime created_at;
  const NotificationModel({
    required this.id,
    required this.user,
    required this.post,
    required this.avatarUserComment,
    required this.nameUserComment,
    required this.title,
    required this.created_at,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
  @override
  String toString() {
    toJson().toString();
    return super.toString();
  }

  @override
  List<Object?> get props =>
      [id, user, post, avatarUserComment, nameUserComment, title, created_at];
}
