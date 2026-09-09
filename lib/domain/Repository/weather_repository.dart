import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_card_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_hero_response.dart';
import '../../core/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherHeroResponse>> getWeatherHero();
  Future<Either<Failure, WeatherCardsResponse>> getWeatherCards();

}