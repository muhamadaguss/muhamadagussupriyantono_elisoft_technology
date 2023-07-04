import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../injector_container.dart';
import '../../model/user_model.dart';
import '../../repositories/dashboard_repository.dart';
import '../../repositories_impl/dashboard_repository_impl.dart';

import '../../model/article_model.dart';
import '../../utils/result.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository dashboardRepository = sl<DashboardRepositoryImpl>();
  int page = 0;
  DashboardCubit() : super(const DashboardState());

  void init() {
    getArticles();
    getFavoriteArticles();
  }

  void getArticles({
    bool loadmore = false,
  }) async {
    emit(
      state.copyWith(
        result: Result.loading(state.result?.data ?? []),
      ),
    );
    List<ArticleModel> articles = [];
    page = loadmore ? page + 1 : 1;
    if (loadmore) {
      articles.addAll(state.result?.data ?? []);
    }
    final response = await dashboardRepository.getArticles(page);
    response.fold((failure) {
      emit(
        state.copyWith(
          result: Result.error(failure.message),
        ),
      );
    }, (result) {
      articles.addAll(result);
      emit(
        state.copyWith(
          result: Result.completed(articles),
        ),
      );
    });
  }

  void getFavoriteArticles() async {
    emit(state.copyWith(
      favoriteResult: Result.loading(),
    ));
    final user = sl<SharedPreferences>().getString('user');
    if (user != null) {
      Map<String, dynamic> jsonData = jsonDecode(user);
      UserModel userModel = UserModel.fromJson(jsonData);
      final response =
          await dashboardRepository.getFavoriteArticles(userModel.uuid ?? '');

      response.fold((failure) {
        emit(
          state.copyWith(
            favoriteResult: Result.error(failure.message),
          ),
        );
      }, (result) {
        emit(
          state.copyWith(
            favoriteResult: Result.completed(result),
          ),
        );
      });
    } else {
      emit(state.copyWith(
        favoriteResult: Result.error('User not found'),
      ));
    }
  }
}
