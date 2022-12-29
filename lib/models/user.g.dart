// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      imageBackground: json['imageBackground'] as String? ?? '',
      postNumber: json['postNumber'] as int? ?? 0,
      totalLikeNumber: json['totalLikeNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phone': instance.phone,
      'displayName': instance.displayName,
      'avatar': instance.avatar,
      'imageBackground': instance.imageBackground,
      'postNumber': instance.postNumber,
      'totalLikeNumber': instance.totalLikeNumber,
    };
