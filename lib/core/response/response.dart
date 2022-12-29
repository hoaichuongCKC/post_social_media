// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_if_null_operators, unnecessary_null_comparison
import 'package:equatable/equatable.dart';
import 'package:post_media_social/models/user.dart';

abstract class ApiResponse {}

class BodyResponse extends Equatable with ApiResponse {
  final String accessToken;
  final String tokenType;
  final String message;
  final int statusCode;
  final UserModel user;
  const BodyResponse({
    this.accessToken = '',
    this.tokenType = '',
    this.message = '',
    this.statusCode = 200,
    this.user = const UserModel(),
  });
  factory BodyResponse.fromJson(Map<String, dynamic> json,
      {int statusCode = 200, UserModel? user}) {
    return BodyResponse(
      accessToken: json["accessToken"] ?? '',
      tokenType: json["tokenType"] ?? '',
      message: json["message"] ?? '',
      user: user ?? const UserModel(),
      statusCode: statusCode,
    );
  }
  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "tokenType": tokenType,
        "message": message,
        "statusCode": statusCode,
        "user": user,
      };
  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [accessToken, tokenType, statusCode, message];
}

class DataResponse<T> extends Equatable with ApiResponse {
  final T data;
  final int statusCode;
  const DataResponse({
    required this.data,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [data, statusCode];

  @override
  String toString() {
    return "$data, $statusCode";
  }
}
