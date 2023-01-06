// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:post_media_social/models/user.dart';
part 'comment_post.g.dart';

List<CommentModel> commentFromJson(String bodyConvert) =>
    List<CommentModel>.from(
      json.decode(bodyConvert).map((x) {
        return CommentModel.fromJson(x);
      }),
    );

@JsonSerializable(explicitToJson: true)
class CommentModel extends Equatable {
  final int id;
  final UserModel user;
  final String message;
  final DateTime created_at;
  const CommentModel({
    required this.id,
    required this.user,
    required this.message,
    required this.created_at,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
  @override
  String toString() {
    toJson().toString();
    return super.toString();
  }

  @override
  List<Object?> get props => [id, user, message, created_at];
}
