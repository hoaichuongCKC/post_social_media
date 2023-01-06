import 'package:flutter/material.dart';
import 'package:post_media_social/common/animations/screen_push/slide_to_left.dart';
import 'package:post_media_social/config/constants.dart';
import 'package:post_media_social/pages/comment/comment_page.dart';
import 'package:post_media_social/pages/image_detail/image_detail_page.dart';
import 'package:post_media_social/pages/home/home_page.dart';
import 'package:post_media_social/pages/login/login_page.dart';
import 'package:post_media_social/pages/my_post/my_post_page.dart';
import 'package:post_media_social/pages/notification/notification_page.dart';
import 'package:post_media_social/pages/otp/otp_page.dart';
import 'package:post_media_social/pages/register/register_page.dart';
import 'package:post_media_social/pages/splash/splash_page.dart';
import 'package:post_media_social/pages/upload_post/upload_post_page.dart';

class AppRoutes {
  static const String initRoute = splashPath;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPath:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case loginPath:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case otpPath:
        return SlideToLeft(
          child: OtpPage(
            phone: settings.arguments.toString(),
          ),
        );
      case registerPath:
        return SlideToLeft(child: const RegisterPage());

      //[follow home]
      case homePath:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case imageDetailPath:
        final String url = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => ImageDetailPage(urlImage: url));

      case uploadPostPath:
        return SlideToLeft(child: const UploadPostPage());

      case myPostPath:
        return SlideToLeft(child: const MyPostPage());

      case notificationPath:
        return SlideToLeft(child: const NotificationPage());
      case commentPath:
        final int postId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => CommentPage(postId: postId));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }

  static void pushNamed(String route, {Object? argument}) =>
      navigatorKey.currentState!.pushNamed(route, arguments: argument);

  static void pushReplacementNamed(String route, {Object? argument}) =>
      navigatorKey.currentState!
          .pushReplacementNamed(route, arguments: argument);

  static void pop() => navigatorKey.currentState!.pop();

  static void pushNameAndRemoveUntil(String route, {bool isRoute = false}) =>
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => isRoute);

  static void popAndPushNamed(String route) =>
      navigatorKey.currentState!.popAndPushNamed(route);
}
