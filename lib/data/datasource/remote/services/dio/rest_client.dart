import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../../constants/constants.dart';
import '../../../../../core/error/exceptions.dart' as dio;
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
      if (e is DioException) {
        if (e.error is dio.LogoutException) {
          throw dio.LogoutException(e.error.toString());
        } else if(e.response?.statusCode == 401) {
          throw dio.LogoutException(e.error.toString());
        }
        else if(e.response?.statusCode == 500 ) {
          throw dio.DioException('Something went wrong');
        } else if(e.response?.statusCode == 503) {
          throw dio.DioException('Something went wrong');
        } else if( e.type == DioExceptionType.unknown) {
          throw dio.DioException('Something went wrong');
        } else if(e.type == DioExceptionType.connectionError) {
          throw dio.DioException('Something went wrong');
        }  else if(e.response?.statusCode == 404) {
          throw dio.DioException('Something went wrong');
        } else if(e.response?.statusCode == null) {
          throw dio.DioException('Something went wrong');
        } else {
          Map<String, dynamic> errorResponse = jsonDecode(e.response?.data ?? {});
          if(errorResponse.containsKey('message')) {
            final String message = errorResponse['message'];
            throw dio.DioException(message);
          }
          throw dio.DioException(e.message.toString());
        }
      }
      if (kDebugMode) {
        print(e);
      }
      throw dio.DioException(Constants.someThingWentWrong);
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
      {if (e is DioException) {
          if (e.error is dio.LogoutException) {
            throw dio.LogoutException(e.error.toString());
          }
          else if(e.response?.statusCode == 500 ) {
            throw dio.DioException('Something went wrong');
          } else if(e.response?.statusCode == 401) {
            throw dio.LogoutException(e.error.toString());
          } else if(e.response?.statusCode == 503) {
            throw dio.DioException('Something went wrong');
          }  else if( e.type == DioExceptionType.unknown) {
            throw dio.DioException('Something went wrong');
          } else if(e.type == DioExceptionType.connectionError) {
            throw dio.DioException('Something went wrong');
          }  else if(e.response?.statusCode == 404) {
            throw dio.DioException('Something went wrong');
          } else if(e.response?.statusCode == null) {
            throw dio.DioException('Something went wrong');
          }else {
            throw _apiError(e.response?.data);
          }
        }
        if (kDebugMode) {
          print(e.toString());
        }
      throw dio.DioException(Constants.someThingWentWrong);
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
      throw dio.DioException(Constants.someThingWentWrong);
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
    throw dio.DioException(Constants.someThingWentWrong);
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
      if (e is DioException) {
        if (e.error is dio.LogoutException) {
          throw dio.LogoutException(e.error.toString());
        } else if (e.response?.statusCode == 401) {
          throw dio.LogoutException(e.error.toString());
        } else if (e.response?.statusCode == 500 ||
            e.response?.statusCode == 503 ||
            e.response?.statusCode == 404) {
          throw dio.DioException('Something went wrong');
        } else if (e.type == DioExceptionType.unknown ||
            e.type == DioExceptionType.connectionError ||
            e.response?.statusCode == null) {
          throw dio.DioException('Something went wrong');
        } else {
          throw _apiError(e.response?.data);
        }
      }

      if (kDebugMode) {
        print(e);
      }

      throw dio.DioException(Constants.someThingWentWrong);
    }
  }

  /// Responses are plain strings; prefers the first field error of a 422 over the generic "Validation failed."
  dio.DioException _apiError(dynamic data) {
    try {
      final body = data is String ? jsonDecode(data) : data;
      final errors = body['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        return dio.DioException((first is List && first.isNotEmpty ? first.first : first).toString(), errors: Map<String, dynamic>.from(errors));
      }
      final message = body['message'];
      if (message is List) return dio.DioException(message.isNotEmpty ? message.first.toString() : 'Something went wrong');
      return dio.DioException(message?.toString() ?? 'Something went wrong');
    } catch (_) {
      return dio.DioException('Something went wrong');
    }
  }
}
