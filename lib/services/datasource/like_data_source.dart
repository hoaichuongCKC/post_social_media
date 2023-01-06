import 'dart:convert';
import 'dart:isolate';
import 'package:post_media_social/core/response/response.dart';
import 'package:http/http.dart' as http;
import '../../core/api/api.dart';

abstract class LikeDataSource {
  Future<DataResponse<String>> likePost(int postId);
}

class LikeDataSourceImpl implements LikeDataSource {
  final Api getApi;

  LikeDataSourceImpl({
    required this.getApi,
  });

  @override
  Future<DataResponse<String>> likePost(int postId) async {
    //uri
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.likePostUrl}");
    ReceivePort port = ReceivePort();
    final isolate = await Isolate.spawn(
        _isoLikePost, [port.sendPort, uri, getApi.headers, postId]);
    String listParam = await port.first;

    isolate.kill(priority: Isolate.immediate);
    return DataResponse(data: listParam, statusCode: 200);
  }

  static void _isoLikePost(List<dynamic> params) async {
    http.MultipartRequest request = http.MultipartRequest('POST', params[1]);

    request.headers.addAll(params[2]);

    request.fields.addAll({"postId": "${params[3]}"});

    //send request up to server
    http.StreamedResponse response = await request.send();

    Map<String, dynamic> map =
        jsonDecode(await response.stream.bytesToString());

    params[0].send(map["message"]);
  }
}
