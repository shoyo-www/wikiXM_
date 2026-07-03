import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../../constants/constants.dart';
import '../../../../../core/error/exceptions.dart' as Dio;
import '../BaseClient.dart';
import '../BaseService.dart';

class RestClient implements BaseService {

  var dioInstance = BaseNetworkClient();

  @override
  Future get({required String url, Map<String, dynamic>? params}) async {
    try {
      final response = await dioInstance
          .getNetworkClient
          .get(url, queryParameters: params);
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.error is Dio.LogoutException) {
          throw Dio.LogoutException(e.error.toString());
        } else if(e.response?.statusCode == 401) {
          throw Dio.LogoutException(e.error.toString());
        }
        else if(e.response?.statusCode == 500 ) {
          throw Dio.DioException('Something went wrong');
        } else if(e.response?.statusCode == 503) {
          throw Dio.DioException('Something went wrong');
        } else if( e.type == DioExceptionType.unknown) {
          throw Dio.DioException('Something went wrong');
        } else if(e.type == DioExceptionType.connectionError) {
          throw Dio.DioException('Something went wrong');
        }  else if(e.response?.statusCode == 404) {
          throw Dio.DioException('Something went wrong');
        } else if(e.response?.statusCode == null) {
          throw Dio.DioException('Something went wrong');
        } else {
          Map<String, dynamic> errorResponse = jsonDecode(e.response?.data ?? {});
          if(errorResponse.containsKey('message')) {
            final String message = errorResponse['message'];
            throw Dio.DioException(message);
          }
          throw Dio.DioException(e.message.toString());
        }
      }
      if (kDebugMode) {
        print(e);
      }
      throw Dio.DioException(Constants.someThingWentWrong);
    }
  }


  @override
  Future post(
      {required String url, required Map<String, dynamic> request,Map<String, dynamic>? params}) async {
    try {
      final response = await dioInstance.getNetworkClient.post(
          url,
          data: request,
          queryParameters: params
      );
      return response.data;
    } catch (e) {
      {if (e is DioError) {
          if (e.error is Dio.LogoutException) {
            throw Dio.LogoutException(e.error.toString());
          }
          else if(e.response?.statusCode == 500 ) {
            throw Dio.DioException('Something went wrong');
          } else if(e.response?.statusCode == 401) {
            throw Dio.LogoutException(e.error.toString());
          } else if(e.response?.statusCode == 503) {
            throw Dio.DioException('Something went wrong');
          }  else if( e.type == DioExceptionType.unknown) {
            throw Dio.DioException('Something went wrong');
          } else if(e.type == DioExceptionType.connectionError) {
            throw Dio.DioException('Something went wrong');
          }  else if(e.response?.statusCode == 404) {
            throw Dio.DioException('Something went wrong');
          } else if(e.response?.statusCode == null) {
            throw Dio.DioException('Something went wrong');
          }else {
            Map<String, dynamic> errorResponse = jsonDecode(e.response?.data);
            dynamic message = errorResponse['message'];
            if (message is List) {
              message = message.isNotEmpty ? message.first.toString() : 'Something went wrong';
            }
            throw Dio.DioException(message?.toString() ?? 'Something went wrong');
          }
        }
        if (kDebugMode) {
          print(e.toString());
        }
      throw Dio.DioException(Constants.someThingWentWrong);
      }
    }
  }

  @override
  Future put(
      {required String url, required Map<String, dynamic> request}) async {
    try {
      final response = await dioInstance
          .getNetworkClient
          .put(url, data: request);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Dio.DioException(Constants.someThingWentWrong);
    }
  }

  @override
  Future delete(
      {required String url, required Map<String, dynamic> request}) async {
    try {
      final response = await dioInstance
          .getNetworkClient
          .delete(url, data: request);
      return response.data;
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    throw Dio.DioException(Constants.someThingWentWrong);
  }

}