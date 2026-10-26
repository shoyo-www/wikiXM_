import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/command_center_response.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/command_center_repository.dart';
import '../../../core/error/exceptions.dart';
import '../remote/services/apis.dart';

CommandCenterResponse parseResponse(String response) {
  return commandCenterResponseFromJson(response);
}

class CommandCenterRepositoryImpl implements CommandCenterRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, CommandCenterResponse>> getData() async {
    try {
      final response = await _restClient.get(url: Apis.commandCenter);
      final politicsResponse = await compute(parseResponse, response as String);
      return Right(politicsResponse);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

