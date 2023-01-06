import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:post_media_social/models/notification.dart';
import '../../core/api/api.dart';

abstract class NotiDataSource {
  Future<DataResponse<List<NotificationModel>>> fetchNoti();
}

class NotiDataSourceImpl implements NotiDataSource {
  final Api getApi;

  NotiDataSourceImpl({
    required this.getApi,
  });

  @override
  Future<DataResponse<List<NotificationModel>>> fetchNoti() async {
    final uri = Uri.parse("${getApi.BASE_URL}${getApi.getNotiUrl}");
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.headers.addAll(getApi.headers);

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    final reBody = json.decode(await response.stream.bytesToString());

    final bodyConvert = json.encode(reBody["data"]);

    final List<NotificationModel> list =
        await compute(notificationFromJson, bodyConvert);

    return DataResponse<List<NotificationModel>>(
        data: list, statusCode: response.statusCode);
  }
}
