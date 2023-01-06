// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/error/exception.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/services/datasource/auth_data_source.dart';

abstract class AuthRepo {
  Future<Either<Failure, BodyResponse>> authUser(
      String username, String password);

  Future<Either<Failure, DataResponse<dynamic>>> me(
      String accessToken, String tokenType);

  Future<Either<Failure, int>> logout();

  Future<Either<Failure, BodyResponse>> authPhone(String phone);

  Future<Either<Failure, BodyResponse>> register(SubmitRegisterEvent event);

  Future<Either<Failure, BodyResponse>> uploadFile(
      File file, String uriRequest);
}

class AuthRepoImpl extends AuthRepo {
  final AuthDataSourceImpl dataSource;

  final NetworkInfoImpl networkInfo;

  AuthRepoImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BodyResponse>> authUser(
      String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.authUser(username, password);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DataResponse<dynamic>>> me(
      String accessToken, String tokenType) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.me(accessToken, tokenType);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, int>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.logout();
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, BodyResponse>> authPhone(String phone) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BodyResponse>> register(
      SubmitRegisterEvent event) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.register(event);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, BodyResponse>> uploadFile(
      File file, String uriRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.uploadFile(file, uriRequest);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
