import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/bloc/upload/upload_post_bloc.dart';
import 'package:post_media_social/bloc/user/user_bloc.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/camera/camera_app.dart';
import 'package:post_media_social/core/image/image_app.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/services/datasource/auth_data_source.dart';
import 'package:post_media_social/services/datasource/post_data_source.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';
import 'package:post_media_social/services/repositories/post_repo.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // //! bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepoImpl: sl()));

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(authRepoImpl: sl()));

  sl.registerFactory<UserBloc>(() => UserBloc(authRepoImpl: sl()));

  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(postRepoImpl: sl()));

  sl.registerFactory<UploadPostBloc>(() => UploadPostBloc(postRepoImpl: sl()));

  //services
  sl.registerLazySingleton(
      () => AuthRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => AuthDataSourceImpl(getApi: sl()));

  sl.registerLazySingleton(
      () => PostRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => PostDataSourceImpl(getApi: sl()));
  // //! Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => Api());

  // //! External
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => CameraServiceApp());

  sl.registerLazySingleton(() => ImageResolveApp());
}
