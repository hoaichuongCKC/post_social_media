// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:post_media_social/core/error/error.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/comment_post.dart';
import 'package:post_media_social/services/datasource/comment_data_source.dart';

import '../../core/error/exception.dart';

abstract class CommentRepo {
  Future<Either<Failure, DataResponse<List<CommentModel>>>> fetchComment(
      int postId);

  Future<Either<Failure, DataResponse<String>>> commentPost(
      int postId, String message);
}

class CommentRepoImpl extends CommentRepo {
  final NetworkInfoImpl networkInfo;
  final CommentDataSourceImpl dataSource;
  CommentRepoImpl({required this.networkInfo, required this.dataSource, S});

  @override
  Future<Either<Failure, DataResponse<List<CommentModel>>>> fetchComment(
      int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.fetchComment(postId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DataResponse<String>>> commentPost(
      int postId, String message) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.commentPost(postId, message);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
