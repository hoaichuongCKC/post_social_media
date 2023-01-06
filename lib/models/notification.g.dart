// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as List<dynamic>,
      avatarUserComment: json['avatarUserComment'] as String,
      nameUserComment: json['nameUserComment'] as String,
      title: json['title'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user.toJson(),
      'post': instance.post,
      'nameUserComment': instance.nameUserComment,
      'avatarUserComment': instance.avatarUserComment,
      'title': instance.title,
      'created_at': instance.created_at.toIso8601String(),
    };
