import 'package:dartz/dartz.dart';
import '../api/error/failures.dart';
import '../model/article_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<ArticleModel>>> getArticles(int page);
  Future<Either<Failure, List<ArticleModel>>> getFavoriteArticles(String uuid);
}
