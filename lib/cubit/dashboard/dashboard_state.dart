part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final Result<List<ArticleModel>>? result;
  final Result<List<ArticleModel>>? favoriteResult;
  const DashboardState({
    this.result,
    this.favoriteResult,
  });

  @override
  List<Object?> get props => [result, favoriteResult];

  DashboardState copyWith({
    Result<List<ArticleModel>>? result,
    Result<List<ArticleModel>>? favoriteResult,
  }) {
    return DashboardState(
      result: result ?? this.result,
      favoriteResult: favoriteResult ?? this.favoriteResult,
    );
  }
}
