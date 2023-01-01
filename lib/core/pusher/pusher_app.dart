// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:post_media_social/config/export.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

abstract class PusherFailure {}

class ErrorPusher extends PusherFailure {
  final String message;
  ErrorPusher({
    required this.message,
  });
}

class AppPusher {
  final String _apiKey = "31c2f5e93dfea03a434d";

  final String _cluster = "ap1";

  final PusherChannelsFlutter _pusherClient =
      PusherChannelsFlutter.getInstance();

  Future initPusher(
      {required Function(PusherEvent) onEvent,
      required Function(String message, int? code, dynamic error) onError,
      required String channelName}) async {
    try {
      await _pusherClient.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onEvent: onEvent,
        onError: onError,
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      await _pusherClient.subscribe(channelName: channelName);
      await _pusherClient.connect();
    } catch (e) {
      debugPrint("ERROR: $e");
      return ErrorPusher(message: e.toString());
    }
  }

  Future disconnectPusher() async => _pusherClient.disconnect();
}
