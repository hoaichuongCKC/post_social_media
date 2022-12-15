import 'package:flutter/material.dart';
import 'package:post_media_social/common/animations/screen_push/slide_to_left.dart';
import 'package:post_media_social/pages/login/login_page.dart';
import 'package:post_media_social/pages/otp/otp_page.dart';
import 'package:post_media_social/pages/splash/splash_page.dart';

class AppRoutes {
  static const String initRoute = "/splash";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/login/otp":
        return SlideToLeft(child: const OtpPage());
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

  static void pop() => navigatorKey.currentState!.pop();

  static void pushNameAndRemoveUntil(String route, {bool isRoute = false}) {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(route, (route) => isRoute);
  }

  static void popAndPushNamed(String route) =>
      navigatorKey.currentState!.popAndPushNamed(route);
}
