// ignore_for_file: non_constant_identifier_names

import 'package:post_media_social/core/hive/user_hive.dart';

class Api {
  final String BASE_URL =
      "https://c19e-2405-4802-a216-e970-b9a6-5261-840c-879a.ap.ngrok.io";

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

  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  void setupHeader(String accessToken, String tokenType) {
    _headers = {
      "Authorization": "$tokenType $accessToken",
      "Accept": "application/json",
    };
  }

  initApi() async {
    final getStorage = await BoxUser.instance.getData();
    if (getStorage != null) {
      _headers = {
        "Authorization": "${getStorage.tokenType} ${getStorage.accessToken}",
        "Accept": "application/json",
      };
    }
  }

  Api() {
    initApi();
  }
}
