// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:post_media_social/models/image_post.dart';
import 'package:post_media_social/models/user.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel extends Equatable {
  final int postId;
  final UserModel user;
  final List<ImagePostModel> image;
  final String content;
  final bool hasMyPost;
  final int likeNumber;
  final int cmtNumber;
  final List likeUser;
  final DateTime created_at;
  const PostModel({
    required this.postId,
    required this.user,
    required this.image,
    required this.content,
    required this.hasMyPost,
    required this.likeNumber,
    required this.cmtNumber,
    required this.likeUser,
    required this.created_at,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
  @override
  String toString() {
    toJson().toString();
    return super.toString();
  }

  @override
  List<Object?> get props => [
        postId,
        user,
        image,
        content,
        hasMyPost,
        likeNumber,
        cmtNumber,
        likeUser,
        created_at
      ];
}
