import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_card_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_hero_response.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/sports_repository.dart';
import 'package:wikixm/domain/Repository/weather_repository.dart';

import '../../../core/error/exceptions.dart';
import '../remote/services/apis.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, WeatherHeroResponse>> getWeatherHero() async {
    try {
      final response = await _restClient.get(url: Apis.weatherHero);
      return Right(weatherHeroResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, WeatherCardsResponse>> getWeatherCards() async {
    try {
      final response = await _restClient.get(url: Apis.weatherCards);
      return Right(weatherCardsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

