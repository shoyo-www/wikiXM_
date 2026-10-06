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
  @override
  Future multipartPost({
    required String url,
    Map<String, dynamic>? fields,
    Map<String, List<String>>? files,
    Map<String, dynamic>? params,
  }) async {
    try {
      final formData = FormData();

      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(
            MapEntry(key, value.toString()),
          );
        });
      }

      if (files != null) {
        for (final entry in files.entries) {
          for (final path in entry.value) {
            formData.files.add(
              MapEntry(
                entry.key,
                await MultipartFile.fromFile(
                  path,
                  filename: path.split('/').last,
                ),
              ),
            );
          }
        }
      }

      final response = await dioInstance.getNetworkClient.post(
        url,
        data: formData,
        queryParameters: params,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.error is Dio.LogoutException) {
          throw Dio.LogoutException(e.error.toString());
        } else if (e.response?.statusCode == 401) {
          throw Dio.LogoutException(e.error.toString());
        } else if (e.response?.statusCode == 500 ||
            e.response?.statusCode == 503 ||
            e.response?.statusCode == 404) {
          throw Dio.DioException('Something went wrong');
        } else if (e.type == DioExceptionType.unknown ||
            e.type == DioExceptionType.connectionError ||
            e.response?.statusCode == null) {
          throw Dio.DioException('Something went wrong');
        } else {
          dynamic data = e.response?.data;
          String message = 'Something went wrong';

          if (data is Map && data['message'] != null) {
            final errorMessage = data['message'];

            if (errorMessage is List) {
              message = errorMessage.isNotEmpty
                  ? errorMessage.first.toString()
                  : message;
            } else {
              message = errorMessage.toString();
            }
          }

          throw Dio.DioException(message);
        }
      }

      if (kDebugMode) {
        print(e);
      }

      throw Dio.DioException(Constants.someThingWentWrong);
    }
  }
}