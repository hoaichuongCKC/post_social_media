import 'package:flutter/material.dart';
import 'package:post_media_social/config/routes.dart';
import 'package:post_media_social/config/theme.dart';
import 'package:post_media_social/pages/home/home_page.dart';
import 'package:post_media_social/pages/profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Post',
      navigatorKey: AppRoutes.navigatorKey,
      initialRoute: AppRoutes.initRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: themeApp,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: 0,
      children: const [
        HomePage(),
        ProfilePage(),
      ],
    );
  }
}
