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
  Future<Either<Failure, DataResponse<List<PostModel>>>> getListPost();

  Future<Either<Failure, DataResponse<String>>> createPost(
      String content, List<File> list);

  Future<Either<Failure, DataResponse<String>>> deletePost(int postId);
}

class PostRepoImpl extends PostRepo {
  final PostDataSourceImpl dataSource;

  final NetworkInfoImpl networkInfo;

  PostRepoImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DataResponse<List<PostModel>>>> getListPost() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.fetchPost();
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
      String content, List<File> list) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.createPost(content, list);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DataResponse<String>>> deletePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.deletePost(postId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
