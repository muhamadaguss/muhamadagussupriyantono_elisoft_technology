import 'package:muhamadagussupriyantono_elisoft_technology/model/article_model.dart';

import 'service_url.dart';
import '../model/user_model.dart';

import '../injector_container.dart';
import 'api_client.dart';
import 'api_response.dart';

class RemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  //post
  Future<ApiResponse<UserModel>> login(Map<String, dynamic> body) async {
    final response = await apiClient.post(ServiceUrl.login, data: body);
    return ApiResponse.fromJson(response, UserModel.fromJson);
  }

  //get
  Future<ApiResponse<ArticleModel>> getArticles(int page) async {
    final response = await apiClient.get('${ServiceUrl.articles}?page=$page');
    return ApiResponse.fromJson(response, ArticleModel.fromJson);
  }

  Future<ApiResponse<ArticleModel>> getFavoriteArticles(String uuid) async {
    final response = await apiClient.get('${ServiceUrl.users}/$uuid/favorites');
    return ApiResponse.fromJson(response, ArticleModel.fromJson);
  }
}
