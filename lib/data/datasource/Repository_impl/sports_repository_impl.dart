import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/sports_repository.dart';

import '../../../core/error/exceptions.dart';
import '../remote/services/apis.dart';

class SportsRepositoryImpl implements SportsRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, SportSectionResponse>> getSportsData() async {
    try {
      final response = await _restClient.get(
        url: Apis.sportsSection, params: {"country_slug": "us", "state": "Washington", "city_id": 46820});
      // big response: parse it off the UI thread like the home and politics repositories
      return Right(await compute(sportSectionResponseFromJson, response as String));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

