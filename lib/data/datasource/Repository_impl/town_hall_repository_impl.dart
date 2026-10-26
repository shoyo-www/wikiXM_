import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/town_hall_response.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/town_hall_repository.dart';
import '../../../core/error/exceptions.dart';
import '../remote/services/apis.dart';

TownHallResponse parseResponse(String response) {
  return townHallResponseFromJson(response);
}

class TownHallRepositoryImpl implements TownHallRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, TownHallResponse>> getData() async {
    try {
      final response = await _restClient.get(url: Apis.townHall);
      final politicsResponse = await compute(parseResponse, response as String);
      return Right(politicsResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

