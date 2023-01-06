import 'package:dartz/dartz.dart';
import 'package:post_media_social/core/error/exception.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/services/datasource/like_data_source.dart';

import '../../core/error/error.dart';

abstract class LikeRepo {
  Future<Either<Failure, DataResponse>> likePost(int postId);

  Future<Either<Failure, DataResponse>> unLikePost(int postId);
}

class LikeRepoImpl extends LikeRepo {
  final LikeDataSourceImpl dataSource;

  final NetworkInfoImpl networkInfo;

  LikeRepoImpl({
    required this.dataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, DataResponse<String>>> likePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.likePost(postId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DataResponse>> unLikePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.likePost(postId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
