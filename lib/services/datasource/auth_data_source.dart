// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/user.dart';

abstract class AuthDataSource {
  Future<BodyResponse> authUser(String username, String password);
  Future<DataResponse<dynamic>> me(String accessToken, String tokenType);
  Future<int> logout();
  Future<BodyResponse> authPhone(String phone);
  Future<BodyResponse> register(SubmitRegisterEvent eventRegister);
  Future<BodyResponse> uploadFile(File file, String uriRequest);
}

class AuthDataSourceImpl implements AuthDataSource {
  final Api getApi;

  AuthDataSourceImpl({
    required this.getApi,
  });

  @override
  Future<BodyResponse> authUser(String username, String password) async {
    final uri = Uri.parse(getApi.BASE_URL + getApi.loginUrl);

    var data;

    final bodyField = {
      "username": username,
      "password": password,
    };

    final response = await http.post(uri, body: bodyField);

    var convert = jsonDecode(response.body);

    UserModel? userModel;

    if (convert["user"] != null) {
      userModel = UserModel.fromJson(convert["user"]);
    }

    data = BodyResponse.fromJson(convert,
        statusCode: response.statusCode, user: userModel);

    return data;
  }

  @override
  Future<DataResponse<dynamic>> me(String accessToken, String tokenType) async {
    final uri = Uri.parse(getApi.BASE_URL + getApi.meUrl);

    final response = await http.post(uri, headers: getApi.headers);

    var convert = jsonDecode(response.body) as Map<String, dynamic>;
    var data;

    if (convert.containsKey("data")) {
      data = UserModel.fromJson(convert["data"]);
    } else if (convert.containsKey("message")) {
      data = convert["message"];
    }

    return DataResponse(data: data, statusCode: response.statusCode);
  }

  @override
  Future<int> logout() async {
    final uri = Uri.parse(getApi.BASE_URL + getApi.logoutUrl);

    await BoxUser.instance.deleteStorageToken();

    final response = await http.post(uri, headers: getApi.headers);

    return response.statusCode;
  }

  @override
  Future<BodyResponse> authPhone(String phone) {
    throw UnimplementedError();
  }

  @override
  Future<BodyResponse> register(SubmitRegisterEvent eventRegister) async {
    //uri register
    final uri = Uri.parse(getApi.BASE_URL + getApi.registerUrl);

    //initial request send up to server
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    //multipart file
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', eventRegister.image.path);

    //add filed file
    request.files.add(multipartFile);

    //filed other
    final bodyField = {
      "username": eventRegister.username,
      "password": eventRegister.password,
      "displayname": eventRegister.displayName,
      "phone": eventRegister.phone,
    };

    request.fields.addAll(bodyField);

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    Map<String, dynamic> map =
        jsonDecode(await response.stream.bytesToString());

    UserModel? userModel;

    if (map.containsKey("user")) {
      userModel = UserModel.fromJson(map["user"]);
    }

    var data;

    data = BodyResponse.fromJson(map,
        statusCode: response.statusCode, user: userModel);

    return data;
  }

  @override
  Future<BodyResponse> uploadFile(File file, String uriRequest) async {
    final uri = Uri.parse(getApi.BASE_URL + uriRequest);
    //initial request send up to server
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    //multipart file
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', file.path);

    //add filed file
    request.files.add(multipartFile);

    request.headers.addAll(getApi.headers);

    //send request up to server
    http.StreamedResponse response = await request.send();

    //body data
    Map<String, dynamic> map =
        jsonDecode(await response.stream.bytesToString());

    return BodyResponse.fromJson(map, statusCode: response.statusCode);
  }
}
