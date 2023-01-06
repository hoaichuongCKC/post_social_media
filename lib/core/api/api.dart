// ignore_for_file: non_constant_identifier_names

import 'package:post_media_social/core/hive/user_hive.dart';

class Api {
  final String BASE_URL =
      "https://4fc4-2405-4802-a216-e970-ad40-d84a-1156-b73c.ap.ngrok.io";

  // [Auth controller]
  final String loginUrl = "/api/auth/login";
  final String meUrl = "/api/auth/me";
  final String logoutUrl = "/api/auth/logout";
  final String registerUrl = "/api/auth/register";
  final String upload_file_background = "/api/auth/upload-file-background";
  final String upload_file_avatar = "/api/auth/upload-file-avatar";

  // [Post controller]
  final String postUrl = "/api/post-control/get-post";
  final String createPostUrl = "/api/post-control/create-post";
  final String deletePostUrl = "/api/post-control/delete-post";

  // [Like controller]
  final String likePostUrl = "/api/like-control/update-like";

  // [Noti controller]
  final String getNotiUrl = "/api/noti-control/get-notification";

  // [Comment controller]
  final String getCommentUrl = "/api/cmt-control/get-comment";
  final String createCommentUrl = "/api/cmt-control/create-comment";

  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  void setupHeader(String accessToken, String tokenType) {
    _headers = {
      "Authorization": "$tokenType $accessToken",
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
  }

  handleGetHeader() async {
    final getStorage = await BoxUser.instance.getData();
    if (getStorage != null) {
      return _headers = {
        "Authorization": "${getStorage.tokenType} ${getStorage.accessToken}",
        "Accept": "application/json",
      };
    }
  }

  Api.initApi() {
    handleGetHeader();
  }
}
