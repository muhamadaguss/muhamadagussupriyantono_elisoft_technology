import 'package:dartz/dartz.dart';
import '../api/error/exception.dart';
import '../api/error/failures.dart';
import '../api/remote_datasource.dart';
import '../model/article_model.dart';
import '../utils/network_info.dart';

import '../repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkInfoImpl networkInfo;
  final RemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getArticles(page);
        if (response.data is List<ArticleModel>) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> getFavoriteArticles(
      String uuid) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getFavoriteArticles(uuid);
        if (response.data is List<ArticleModel>) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
