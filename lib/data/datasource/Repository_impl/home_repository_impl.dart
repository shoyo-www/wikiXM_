import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_cat.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_local.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/search_town.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_alerts.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/Repository/auth_repository.dart';
import '../../../domain/Repository/home_repository.dart';
import '../remote/models/request/login_request.dart';
import '../remote/models/response/login_response.dart';
import '../remote/services/apis.dart';
import '../remote/services/dio/rest_client.dart';

HomeResponse parseHomeResponse(String response) {
  return homeResponseFromJson(response);
}

HomeCatResponse parseHomeCatResponse(String response) {
  return homeCatResponseFromJson(response);
}

class HomeRepositoryImpl implements HomeRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, HomeResponse>> getHomeData() async {
    try {
      final response = await _restClient.get(url: Apis.home);
      final homeResponse = await compute(parseHomeResponse, response as String);
      return Right(homeResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, WeatherAlertsResponse>> getWeatherAlerts(int city,String type) async {
    try {
      final response = await _restClient.get(url: Apis.weather,params: {
        "area_id" : city,
        "area_type" : type
      });
      return Right(weatherAlertsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeCatResponse>> getHomeInterests() async{
    try {
      final response = await _restClient.get(url: Apis.homeInterests);
      final homeResponse = await compute(parseHomeCatResponse, response as String);
      return Right(homeResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeLocalResponse>> getHomeLocal() async {
    try {
      final response = await _restClient.get(url: Apis.homeLocal);
      return Right(homeLocalResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SearchTownResponse>> searchTown(String town) async {
    try {
      final response = await _restClient.get(url: Apis.searchTowns,params: {"search" : town});
      return Right(searchTownResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}