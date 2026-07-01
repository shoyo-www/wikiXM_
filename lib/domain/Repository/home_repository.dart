import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_cat.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_local.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/search_town.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_alerts.dart';
import '../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeResponse>> getHomeData();
  Future<Either<Failure, HomeCatResponse>> getHomeInterests();
  Future<Either<Failure, HomeLocalResponse>> getHomeLocal();
  Future<Either<Failure, WeatherAlertsResponse>> getWeatherAlerts(int cityId,String cityType);
  Future<Either<Failure, SearchTownResponse>> searchTown(String town);
}