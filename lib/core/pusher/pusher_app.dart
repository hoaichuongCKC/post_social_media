// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:post_media_social/config/export.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherConfig {
  static const String appKey = "31c2f5e93dfea03a434d";

  static const String cluster = "ap1";
}

class AppPusher {
  final PusherChannelsFlutter pusherClient =
      PusherChannelsFlutter.getInstance();

  Future initPusher(
      {required dynamic Function(dynamic)? onEvent,
      Function(String message, int? code, dynamic error)? onError,
      required String channelName}) async {
    try {
      await pusherClient.init(
          apiKey: PusherConfig.appKey,
          cluster: PusherConfig.cluster,
          onError: onError,
          authParams: {
            'headers': sl.get<Api>().headers,
          }
          // authEndpoint: "<Your Authendpoint>",
          // onAuthorizer: onAuthorizer
          );

      await pusherClient.subscribe(
        channelName: channelName,
        onEvent: onEvent,
      );

      await pusherClient.connect();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  Future trigger(String channelName, String eventName,
          Map<String, dynamic> data) async =>
      await pusherClient.trigger(PusherEvent(
          channelName: channelName, eventName: eventName, data: data));

  Future disconnect() async => await pusherClient.disconnect();
}
