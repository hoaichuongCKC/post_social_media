// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_overrides, must_be_immutable

import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/api/api.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String accessToken;

  @HiveField(2)
  String tokenType;

  @HiveField(3)
  String displayName;

  @HiveField(4)
  String avatar;

  @HiveField(5)
  String imageBackground;

  @HiveField(6)
  String username;
  UserHive({
    this.id = 0,
    this.username = '',
    this.displayName = '',
    this.avatar = '',
    this.imageBackground = '',
    this.accessToken = '',
    this.tokenType = '',
  });

  @override
  String toString() {
    return "id: $id, token: $accessToken, tokenType: $tokenType, user: $displayName, $avatar, $imageBackground, $username";
  }
}

abstract class UserQuery {
  Future setData(UserHive hive);

  Future editAvatar(String url);

  Future editBackground(String url);

  Future deleteStorageToken();

  Future getData();
}

class BoxUser extends UserQuery {
  BoxUser._();

  static BoxUser instance = BoxUser._();

  static String nameBox = "user-hive";

  Future<Box<UserHive>> initBox() async =>
      await Hive.openBox<UserHive>(nameBox);

  @override
  Future getData() async {
    final box = await initBox();
    final data = box.values.toList();
    if (data.isEmpty) {
      return null;
    }
    return data[0];
  }

  @override
  Future deleteStorageToken() async {
    final box = await initBox();

    // print(box.values.first);
    final data = box.values.first;

    await data.delete();
  }

  @override
  Future setData(UserHive hive) async {
    final box = await initBox();
    sl.get<Api>().setupHeader(hive.accessToken, hive.tokenType);
    await box.add(hive);
  }

  @override
  Future editAvatar(String url) async {
    final box = await initBox();

    final data = box.values.first;

    data.avatar = url;

    await data.save();
  }

  @override
  Future editBackground(String url) async {
    final box = await initBox();

    final data = box.values.first;

    data.imageBackground = url;

    data.save();
  }
}
