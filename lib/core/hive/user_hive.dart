// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_overrides, must_be_immutable
import 'package:hive/hive.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String tokenType;

  @HiveField(2)
  String displayName;

  @HiveField(3)
  String avatar;

  @HiveField(4)
  String imageBackground;
  UserHive({
    this.accessToken = '',
    this.tokenType = '',
    this.displayName = '',
    this.avatar = '',
    this.imageBackground = '',
  });

  @override
  String toString() {
    return "token: $accessToken, tokenType: $tokenType, user: $displayName, $avatar, $imageBackground";
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

  Future<Box<UserHive>> initBox() async => Hive.openBox<UserHive>(nameBox);

  @override
  Future getData() async {
    final box = await initBox();

    final data = box.values.toList().cast<UserHive>();

    if (data.isEmpty) {
      return null;
    }
    return data[0];
  }

  @override
  Future deleteStorageToken() async {
    final box = await initBox();

    final data = box.values.first;

    data.delete();
  }

  @override
  Future setData(UserHive hive) async {
    final box = await initBox();

    await box.add(hive);
  }

  @override
  Future editAvatar(String url) async {
    final box = await initBox();

    final data = box.values.first;

    data.avatar = url;

    data.save();
  }

  @override
  Future editBackground(String url) async {
    final box = await initBox();

    final data = box.values.first;

    data.imageBackground = url;

    data.save();
  }
}
