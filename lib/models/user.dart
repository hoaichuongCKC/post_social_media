// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String username;
  final String phone;
  final String displayName;
  final String avatar;
  final String imageBackground;
  final int postNumber;
  final int totalLikeNumber;

  const UserModel({
    this.id = 0,
    this.username = '',
    this.phone = '',
    this.displayName = '',
    this.avatar = '',
    this.imageBackground = '',
    this.postNumber = 0,
    this.totalLikeNumber = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  List<Object?> get props => [
        id,
        username,
        displayName,
        avatar,
        imageBackground,
        totalLikeNumber,
        postNumber
      ];

  @override
  String toString() {
    toJson().toString();
    return super.toString();
  }
}
