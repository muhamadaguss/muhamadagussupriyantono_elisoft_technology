import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../injector_container.dart';
import '../routes/app_pages.dart';

class ApiClient extends DioForNative {
  ApiClient() : super() {
    var urlHOST = dotenv.env['URL'];
    options = BaseOptions(
      baseUrl: urlHOST!,
      connectTimeout: 1000 * 60,
      receiveTimeout: (options.connectTimeout * 0.6).toInt(),
      validateStatus: (status) {
        return true;
      },
    );

    interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      // responseBody: false,
    ));
    // final user = sl<SharedPreferences>().getString('user');
    // final userData = user != null ? UserModel.fromJson(user) : null;

    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers = <String, dynamic>{
        "token": 'Bearer ${sl<SharedPreferences>().getString('token')}',
      };
      return handler.next(options);
    }, onResponse: (response, handler) {
      _ifTokenExpired(response);
      return handler.next(response);
    }, onError: (DioError e, handler) {
      if (e.type == DioErrorType.connectTimeout) {
        // Handle request time out

        // tokenRTO(e.response);
        //  return tokenRTO(e.response);
      }
      _ifTokenExpired(e.response);
      return handler.next(e);
    }));
  }
}

void _ifTokenExpired(Response<dynamic>? response) {
  if (response?.statusCode == 91) {
    sl<SharedPreferences>().remove('token');
    sl<GlobalKey<NavigatorState>>()
        .currentState
        ?.pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);
  }

  if ((response?.statusCode == 400 || response?.statusCode == 401) &&
      response?.data is Map<String, dynamic>) {
    if (response?.data['message'] is String) {
      final message = (response?.data['message'] as String).toLowerCase();

      if (message.contains('token') && message.contains('expired')) {
        sl<SharedPreferences>().remove('token');
        sl<GlobalKey<NavigatorState>>()
            .currentState
            ?.pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);
      }
    }
  }
}


// void tokenRTO(Response<dynamic>? response) {
//     sl<GlobalKey<NavigatorState>>().currentState?.pushNamedAndRemoveUntil(Routes.rto, (route) => false);

 
// }
