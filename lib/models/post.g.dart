// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      postId: json['postId'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      image: (json['image'] as List<dynamic>)
          .map((e) => ImagePostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String,
      likeNumber: json['likeNumber'] as int,
      cmtNumber: json['cmtNumber'] as int,
      likeUser: json['likeUser'] as List<dynamic>,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'postId': instance.postId,
      'user': instance.user.toJson(),
      'image': instance.image.map((e) => e.toJson()).toList(),
      'content': instance.content,
      'likeNumber': instance.likeNumber,
      'cmtNumber': instance.cmtNumber,
      'likeUser': instance.likeUser,
      'created_at': instance.created_at.toIso8601String(),
    };
