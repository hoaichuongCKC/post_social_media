import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:post_media_social/models/comment_post.dart';
import '../../core/api/api.dart';

abstract class CommentDateSource {
  Future<DataResponse<List<CommentModel>>> fetchComment(int postId);

  Future<DataResponse<String>> commentPost(int postId, String message);
}

class CommentDataSourceImpl implements CommentDateSource {
  final Api getApi;

  CommentDataSourceImpl({
    required this.getApi,
  });

  @override
  Future<DataResponse<List<CommentModel>>> fetchComment(int postId) async {
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.getCommentUrl}");
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.headers.addAll(getApi.headers);
    request.fields.addAll({
      "postId": "$postId",
    });

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    final reBody = json.decode(await response.stream.bytesToString());

    final bodyConvert = json.encode(reBody["data"]);

    final List<CommentModel> list = await compute(commentFromJson, bodyConvert);

    return DataResponse<List<CommentModel>>(
        data: list, statusCode: response.statusCode);
  }

  @override
  Future<DataResponse<String>> commentPost(int postId, String message) async {
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.createCommentUrl}");
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.headers.addAll(getApi.headers);
    request.fields.addAll({
      "postId": "$postId",
      "message": message,
    });

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    final reBody = json.decode(await response.stream.bytesToString());

    final bodyConvert = json.encode(reBody["message"]);

    return DataResponse<String>(
        data: bodyConvert, statusCode: response.statusCode);
  }
}
