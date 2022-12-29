import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/bloc/user/user_bloc.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/services/datasource/auth_data_source.dart';
import 'package:post_media_social/services/repositories/auth_repo.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // //! bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepoImpl: sl()));

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(authRepoImpl: sl()));

  sl.registerFactory<UserBloc>(() => UserBloc(authRepoImpl: sl()));

  //services
  sl.registerLazySingleton(
      () => AuthRepoImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => AuthDataSourceImpl(getApi: sl()));

  // //! Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => Api());

  // //! External
  sl.registerLazySingleton(() => Connectivity());
}
