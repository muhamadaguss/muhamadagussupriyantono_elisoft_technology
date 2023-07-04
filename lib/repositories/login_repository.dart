import 'package:dartz/dartz.dart';
import '../api/error/failures.dart';
import '../model/user_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> login(Map<String, dynamic> body);
}
