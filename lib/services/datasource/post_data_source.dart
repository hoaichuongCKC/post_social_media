import 'dart:convert';
import 'dart:io';

import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/post.dart';
import 'package:http/http.dart' as http;
import '../../core/api/api.dart';

abstract class PostDataSource {
  Future<DataResponse<List<PostModel>>> getListPost(int page, int limit);
  Future<DataResponse<String>> createPost(String content, File file);
}

class PostDataSourceImpl implements PostDataSource {
  final Api getApi;

  PostDataSourceImpl({
    required this.getApi,
  });

  @override
  Future<DataResponse<List<PostModel>>> getListPost(int page, int limit) async {
    //uri
    final uri = Uri.parse(
        "${getApi.BASE_URL}${getApi.postUrl}?page=$page&limit=$limit");

    // get token
    final getStorage = await BoxUser.instance.getData();

    final headers = {
      "Authorization": "${getStorage.tokenType} ${getStorage.accessToken}",
      "Accept": "application/json",
    };

    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    final reBody = json.decode(await response.stream.bytesToString());

    final bodyConvert = json.encode(reBody["data"]);

    final List<PostModel> list =
        List<PostModel>.from(json.decode(bodyConvert).map((x) {
      return PostModel.fromJson(x);
    }));

    return DataResponse<List<PostModel>>(
        data: list, statusCode: response.statusCode);
  }

  @override
  Future<DataResponse<String>> createPost(String content, File file) async {
    //uri
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.postUrl}");

    // get token
    final getStorage = await BoxUser.instance.getData();

    final headers = {
      "Authorization": "${getStorage.tokenType} ${getStorage.accessToken}",
      "Accept": "application/json",
    };

    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);

    request.fields.addAll({"content": content});

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', file.path);

    //add filed file
    request.files.add(multipartFile);

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    final reBody = json.decode(await response.stream.bytesToString());

    final bodyConvert = json.encode(reBody["message"]);

    return DataResponse<String>(
        data: bodyConvert, statusCode: response.statusCode);
  }
}
