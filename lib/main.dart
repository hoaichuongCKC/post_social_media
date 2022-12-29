// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/firebase_options.dart';
import 'config/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await Hive.initFlutter();

  Hive.registerAdapter(UserHiveAdapter());

  await BoxUser.instance.initBox();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Post',
      scrollBehavior: const ScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      scaffoldMessengerKey: AppSnackbar.scaffoldMessengerKey,
      navigatorKey: AppRoutes.navigatorKey,
      initialRoute: AppRoutes.initRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: themeApp,
    );
  }
}
