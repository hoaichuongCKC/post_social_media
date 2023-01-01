import 'dart:convert';
import 'dart:io';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/post.dart';
import 'package:http/http.dart' as http;
import '../../core/api/api.dart';

abstract class PostDataSource {
  Future<DataResponse<List<PostModel>>> getListPost(int page, int limit);
  Future<DataResponse<String>> createPost(String content, List<File> listFile);
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

    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    print(getApi.headers);
    request.headers.addAll(getApi.headers);

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
  Future<DataResponse<String>> createPost(
      String content, List<File> listFile) async {
    //uri
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.createPostUrl}");

    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    //add header uri
    request.headers.addAll(getApi.headers);

    //add field
    request.fields.addAll({"content": content});

    Map<String, dynamic> rebody = {};

    //add file
    if (listFile.isNotEmpty) {
      if (listFile.length == 1) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image[]', listFile[0].path);

        //add filed file
        request.files.add(multipartFile);
      } else {
        for (File file in listFile) {
          http.MultipartFile multipartFile =
              await http.MultipartFile.fromPath('image[]', file.path);

          //add filed file
          request.files.add(multipartFile);
        }
      }
    }

    http.StreamedResponse response = await request.send();

    rebody = json.decode(await response.stream.bytesToString());

    //body data

    final bodyConvert = rebody["message"];

    return DataResponse<String>(
        data: bodyConvert, statusCode: response.statusCode);
  }
}
