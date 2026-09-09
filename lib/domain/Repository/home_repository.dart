import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_feed.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_overview.dart';
import 'package:wikixm/data/datasource/remote/models/response/community_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/entertainment_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_insights.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_local.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_market_place.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/search_town.dart';
import 'package:wikixm/data/datasource/remote/models/response/search_town_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_alerts.dart';
import '../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeResponse>> getHomeData();
  Future<Either<Failure, CommunityResponse>> getHomeCommunity();
  Future<Either<Failure, HomeLocalResponse>> getHomeLocal();
  Future<Either<Failure, WeatherAlertsResponse>> getWeatherAlerts();
  Future<Either<Failure, SearchTownResponse>> searchTown(String town);
  Future<Either<Failure, HomeInsightsResponse>> homeInsights();
  Future<Either<Failure, HomeMarketPlace>> homeMarketPlace();
  Future<Either<Failure, CommunityOverviewResponse>> communityOverview();
  Future<Either<Failure, CommunityFeedResponse>> communityFeed();
  Future<Either<Failure, EntertainmentResponse>> getEntertainment();
}