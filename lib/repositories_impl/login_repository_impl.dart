import 'package:dartz/dartz.dart';
import '../api/error/exception.dart';
import '../api/error/failures.dart';
import '../api/remote_datasource.dart';
import '../model/user_model.dart';
import '../utils/network_info.dart';

import '../repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfoImpl networkInfo;
  final RemoteDataSource remoteDataSource;

  LoginRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> login(Map<String, dynamic> body) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(body);
        if (response.data is UserModel) {
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
