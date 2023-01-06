import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/comment/comment_bloc.dart';
import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/bloc/like/like_bloc.dart';
import 'package:post_media_social/bloc/notification/notification_bloc.dart';
import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/bloc/upload/upload_post_bloc.dart';
import 'package:post_media_social/bloc/user/user_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/services/datasource/auth_data_source.dart';
import 'package:post_media_social/services/datasource/comment_data_source.dart';
import 'package:post_media_social/services/datasource/like_data_source.dart';
import 'package:post_media_social/services/datasource/noti_data_source.dart';
import 'package:post_media_social/services/datasource/post_data_source.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';
import 'package:post_media_social/services/repositories/comment_repo.dart';
import 'package:post_media_social/services/repositories/like_repo.dart';
import 'package:post_media_social/services/repositories/noti_repo.dart';
import 'package:post_media_social/services/repositories/post_repo.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  //---------------------------[register bloc]-----------------------------
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepoImpl: sl()));

  sl.registerFactory<LikeBloc>(() => LikeBloc(likeRepoImpl: sl()));

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(authRepoImpl: sl()));

  sl.registerFactory<UserBloc>(() => UserBloc(authRepoImpl: sl()));

  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(postRepoImpl: sl()));

  sl.registerFactory<UploadPostBloc>(() => UploadPostBloc(postRepoImpl: sl()));

  sl.registerLazySingleton<NotificationBloc>(
      () => NotificationBloc(notiRepoImpl: sl()));

  sl.registerFactory<CommentBloc>(() => CommentBloc(cmtRepo: sl()));

  //---------------------------[register service]-----------------------------
  sl.registerLazySingleton(
      () => AuthRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => AuthDataSourceImpl(getApi: sl()));

  sl.registerLazySingleton(
      () => PostRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => PostDataSourceImpl(getApi: sl()));

  sl.registerLazySingleton(
      () => LikeRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => LikeDataSourceImpl(getApi: sl()));

  sl.registerLazySingleton(
      () => NotiRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => NotiDataSourceImpl(getApi: sl()));

  sl.registerLazySingleton(
      () => CommentRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => CommentDataSourceImpl(getApi: sl()));

  //---------------------------[register core]-----------------------------
  // //! Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => Api.initApi());

  // //! External

  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => CameraServiceApp());

  sl.registerLazySingleton(() => ImageCompressService());
}
