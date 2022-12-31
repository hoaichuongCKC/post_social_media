// ignore_for_file: non_constant_identifier_names

class Api {
  final String BASE_URL =
      "https://6e64-2405-4802-a216-e970-6d50-e1c4-66cf-cb0c.ap.ngrok.io";

  // [Auth controller]
  final String loginUrl = "/api/auth/login";
  final String meUrl = "/api/auth/me";
  final String logoutUrl = "/api/auth/logout";
  final String registerUrl = "/api/auth/register";
  final String upload_file_background = "/api/auth/upload-file-background";
  final String upload_file_avatar = "/api/auth/upload-file-avatar";

  // [Post controller]
  final String postUrl = "/api/post-control/get-post";
}
