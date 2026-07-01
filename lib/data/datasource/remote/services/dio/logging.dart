import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../local/local_storage.dart';

class Logging extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    options.headers.addAll({
      'Authorization':
      'Bearer 1661|mhdb6AM328K8OjBE9yvybDl9GDvjd9GuNCtkzlXf7a0b5082',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': 'en-US',
      'User-Agent': 'Flutter/${Platform.operatingSystem}',
      'Connection': 'keep-alive',
      'Cache-Control': 'no-cache',
      'Pragma': 'no-cache',
    });

    if (kDebugMode) {
      print('════════ REQUEST ════════');
      print('METHOD : ${options.method}');
      print('URL    : ${options.uri}');
      print('HEADERS');
      options.headers.forEach((key, value) {
        print('$key : $value');
      });
      print('QUERY  : ${options.queryParameters}');
      print('BODY   : ${options.data}');
      print('═════════════════════════');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('STATUS CODE -:> ${response.statusCode}');
      log('RESPONSE-:> ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('ERROR CODE -:> ${err.response?.statusCode}');
      log('ERROR RESPONSE -:> ${err.response?.data}');
      print('ERROR MESSAGE -:> ${err.message}');
    }
    return super.onError(err, handler);
  }
}