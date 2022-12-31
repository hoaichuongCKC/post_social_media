// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/error/exception.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/post.dart';
import 'package:post_media_social/services/datasource/post_data_source.dart';

abstract class PostRepo {
  Future<Either<Failure, DataResponse<List<PostModel>>>> getListPost(
      int page, int limit);
  Future<Either<Failure, DataResponse<String>>> createPost(
      String content, File file);
}

class PostRepoImpl extends PostRepo {
  final PostDataSourceImpl dataSource;

  final NetworkInfoImpl networkInfo;

  PostRepoImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DataResponse<List<PostModel>>>> getListPost(
      int page, int limit) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.getListPost(page, limit);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DataResponse<String>>> createPost(
      String content, File file) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.createPost(content, file);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
