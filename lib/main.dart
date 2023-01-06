// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_media_social/bloc/comment/comment_bloc.dart';
import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/bloc/like/like_bloc.dart';
import 'package:post_media_social/bloc/notification/notification_bloc.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/firebase_options.dart';
import 'config/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  Directory? tempDir = await getApplicationDocumentsDirectory();

  String tempPath = tempDir.path;

  await Hive.initFlutter(tempPath);

  Hive.registerAdapter(UserHiveAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LikeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<NotificationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CommentBloc>(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
