import 'package:dartz/dartz.dart';
import 'package:post_media_social/core/error/exception.dart';
import 'package:post_media_social/core/network/network_info.dart';
import 'package:post_media_social/core/response/response.dart';
import 'package:post_media_social/models/notification.dart';

import '../../core/error/error.dart';
import '../datasource/noti_data_source.dart';

abstract class NotiRepo {
  Future<Either<Failure, DataResponse>> getNoti();

  // Future<Either<Failure, DataResponse>> unLikePost(int postId);
}

class NotiRepoImpl extends NotiRepo {
  final NotiDataSourceImpl dataSource;

  final NetworkInfoImpl networkInfo;

  NotiRepoImpl({
    required this.dataSource,
    required this.networkInfo,
  });
  // @override
  // Future<Either<Failure, DataResponse<String>>> likePost(int postId) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final data = await dataSource.likePost(postId);
  //       return Right(data);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(InternetFailure());
  //   }
  // }

  @override
  Future<Either<Failure, DataResponse<List<NotificationModel>>>>
      getNoti() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await dataSource.fetchNoti();
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
