//Api respone mas rafi

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_pagination.dart';
import 'error/exception.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final dynamic data;
  final Response? responseBase;
  final int statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    this.responseBase,
  });

  factory ApiResponse.fromJson(
    Response response,
    T Function(Map<String, dynamic> json)? fromJson, {
    bool pagination = false,
  }) {
    if (response.data is String) {
      if (response.data.isEmpty) {
        final statusCode = (response.statusCode ?? 0) >= 200 &&
            (response.statusCode ?? 0) < 300;
        final message = statusCode ? 'Success' : 'Error';

        return ApiResponse(
          success: statusCode,
          message: message,
          statusCode: response.data["statusCode"],
          data: null,
        );
      }
    }

    if (response.data is! Map<String, dynamic>) {
      debugPrint('response.data: ${response.data}');
      throw ServerException(
          'Response bukan JSON\nSilahkan cek Kesalahan di API',
          response.statusCode ?? 500);
    }

    final Map<String, dynamic> json = response.data;
    // if (json['status'] is! bool) {
    //   throw ServerException(
    //       'Response key "success" bukan boolean', response.statusCode ?? 500);
    // }

    // if (json['message'] is! String) {
    //   throw ServerException(
    //       'Response key "message" bukan string', response.statusCode ?? 500);
    // }

    if (json['status'] == 0 || response.statusCode != 200) {
      if (response.statusCode == 422) {
        throw ServerException(
          jsonEncode(response.data),
          response.statusCode ?? 500,
        );
      }
      if (json['message'].toString().trim().isNotEmpty) {
        throw ServerException(
            json['message'].toString().trim(), response.statusCode ?? 500);
      } else if (json['message'].toString().trim().isEmpty) {
        throw ServerException(
            'Response key "success" true tapi messagenya kosong',
            response.statusCode ?? 500);
      }
    }

    if (json['status'] == 0 || response.statusCode != 200) {
      if (response.statusCode == 422) {
        throw ServerException(
          jsonEncode(response.data),
          response.statusCode ?? 500,
        );
      }
      if (json['message'].toString().trim().isNotEmpty) {
        throw ServerException(
            json['message'].toString().trim(), response.statusCode ?? 500);
      } else if (json['message'].toString().trim().isEmpty) {
        throw ServerException(
            'Response key "success" true tapi messagenya kosong',
            response.statusCode ?? 500);
      }
    }

    dynamic data;

    if (json['user'] != null) {
      final jsonData = json['user'].toString();

      if (jsonData.isNotEmpty) {
        if (fromJson != null) {
          if (pagination) {
            data = ApiPagination<T>.fromJson(json['user'], fromJson.call);
          } else if (jsonData[0] == '[') {
            data = (json['user'] as List<dynamic>).map((e) {
              return fromJson.call(e);
            }).toList();
          } else if (jsonData[0] == '{') {
            data = fromJson.call(json['user']);
          }
        } else if (json['user'] is List<dynamic>) {
          data = (json['user'] as List<dynamic>).map<Map<String, dynamic>>((e) {
            return e;
          }).toList();
        } else {
          data = json['user'];
        }
      }
    } else if (json['articles'] != null) {
      final jsonData = json['articles'].toString();

      if (jsonData.isNotEmpty) {
        if (fromJson != null) {
          if (pagination) {
            data = ApiPagination<T>.fromJson(json['articles'], fromJson.call);
          } else if (jsonData[0] == '[') {
            data = (json['articles'] as List<dynamic>).map((e) {
              return fromJson.call(e);
            }).toList();
          } else if (jsonData[0] == '{') {
            data = fromJson.call(json['articles']);
          }
        } else if (json['articles'] is List<dynamic>) {
          data = (json['articles'] as List<dynamic>)
              .map<Map<String, dynamic>>((e) {
            return e;
          }).toList();
        } else {
          data = json['articles'];
        }
      }
    }

    return ApiResponse(
      success: json['status'],
      message: json['message'] ?? 'Pesan tidak dikenal',
      statusCode: json['status'] ? 200 : 500,
      data: data,
      responseBase: response,
    );
  }
}
