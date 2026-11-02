import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_feed.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_overview.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/entertainment_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_cat.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_insights.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_local.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_market_place.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/search_town.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_alerts.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/Repository/home_repository.dart';
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
  Future<Either<Failure, WeatherAlertsResponse>> getWeatherAlerts() async {
    try {
      final response = await _restClient.get(url: Apis.weather);
      // the Home responses land while pages are animating; parse them off the UI thread like getHomeData
      return Right(await compute(weatherAlertsResponseFromJson, response as String));
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
      final response = await _restClient.get(url: Apis.searchTowns,params: {"q" : town});
      return Right(searchTownResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CommunityResponse>> getHomeCommunity() async {
    try {
      final response = await _restClient.get(url: Apis.communityHome);
      return Right(await compute(communityResponseFromJson, response as String));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeInsightsResponse>> homeInsights() async {
    try {
      final response = await _restClient.get(url: Apis.homeInsights);
      return Right(await compute(homeInsightsResponseFromJson, response as String));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeMarketPlace>> homeMarketPlace() async {
    try {
      final response = await _restClient.get(url: Apis.homeMarketPlace);
      return Right(await compute(homeMarketPlaceFromJson, response as String));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CommunityOverviewResponse>> communityOverview() async {
    try {
      final response = await _restClient.get(url: Apis.communityOverview);
      return Right(communityOverviewResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CommunityFeedResponse>> communityFeed() async {
    try {
      final response = await _restClient.get(url: Apis.communityFeed);
      return Right(communityFeedResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, EntertainmentResponse>> getEntertainment() async {
    try {
      final response = await _restClient.get(url: Apis.entertainment);
      return Right(entertainmentResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }



}