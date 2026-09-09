import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/Education_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/sports_repository.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/Repository/education_repository.dart';
import '../remote/services/apis.dart';

EducationHomeResponse parseResponse(String response) {
  return educationHomeResponseFromJson(response);
}

class EducationRepositoryImpl implements EducationRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, EducationHomeResponse>> getEducationData() async {
    try {
      final response = await _restClient.get(url: Apis.education);
      final homeResponse = await compute(parseResponse, response as String);
      return Right(homeResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

