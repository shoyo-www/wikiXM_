import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/request/image_upload.dart';
import 'package:wikixm/data/datasource/remote/models/request/no_params_req.dart';
import 'package:wikixm/data/datasource/remote/models/response/common_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/draft_item_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/image_analyse.dart';
import 'package:wikixm/data/datasource/remote/models/response/image_upload_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_brief_ai.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_brief_charts.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_filters.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_place.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_place_content.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_AI.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_dashboard.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/Repository/garage_repository.dart';
import '../remote/models/response/market_brief.dart';
import '../remote/services/apis.dart';

MarketPlaceResponse parseResponse(String response) {
  return marketPlaceResponseFromJson(response);
}

class GarageRepositoryImpl implements GarageRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, CreateItemDraft>> draft(NoParamsRequest request) async {
    try {
      final response = await _restClient.post(url: Apis.createItemDraft, request: request.toJson());
      return Right(createItemDraftFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ImageUploadResponse>> uploadImage(FileUploadRequest request, int itemId) async {
    try {
      final response = await _restClient.multipartPost(
        url: '${Apis.addImage}$itemId/images',
        files: {
          'file': [request.filePath],
        },
      );
      return Right(imageUploadResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> deleteImage(int itemId, int imageId) async {
    try {
      final response = await _restClient.delete(url: '${Apis.deleteImage}$itemId/images/$imageId', request: {});
      return Right(commonResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ImageAnalyseResponse>> analyseImage(int itemId) async {
    try {
      final response = await _restClient.post(url: '${Apis.analyseImage}$itemId/analyse', request: {});
      return Right(imageAnalyseResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketBriefResponse>> marketBrief(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.marketBrief, params: {"city_id": cityId});
      return Right(marketBriefResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketAiBriefResponse>> marketAiBrief(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.marketAiBrief, params: {"city_id": cityId});
      return Right(marketAiBriefResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketBriefChartsResponse>> marketBriefCharts(int cityId, int months) async {
    try {
      final response = await _restClient.get(url: Apis.marketBriefCharts, params: {"city_id": cityId, "months": months});
      return Right(marketBriefChartsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketPlaceResponse>> marketPlace(Map<String,dynamic> params) async {
    try {
      final response = await _restClient.get(url: Apis.marketPlace, params: params);
      final marketResponse = await compute(parseResponse, response as String);
      return Right(marketResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketPlaceContentResponse>> marketPlaceContent(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.marketPlaceContent, params: {"city_id": cityId});
      return Right(marketPlaceContentResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MarketPlaceFiltersResponse>> marketPlaceFilters(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.marketPlaceFilters, params: {"city_id": cityId});
      return Right(marketPlaceFiltersResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MyGarageDashboardResponse>> myGarage() async {
    try {
      final response = await _restClient.get(url: Apis.myGarage);
      return Right(myGarageDashboardResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MyGarageAiResponse>> myGarageAI() async {
    try {
      final response = await _restClient.post(url: Apis.myGarageAI,request: {});
      return Right(myGarageAiResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
