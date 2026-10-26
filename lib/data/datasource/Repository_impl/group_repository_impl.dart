import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import 'package:wikixm/data/datasource/remote/models/response/interest_detail.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/group_repository.dart';
import '../../../core/error/exceptions.dart';
import '../remote/models/response/group_home.dart';
import '../remote/services/apis.dart';

GroupHomeResponse parseResponse(String response) {
  return groupHomeResponseFromJson(response);
}

GroupSectionsResponse parseSection(String response) {
  return groupSectionsResponseFromJson(response);
}

class GroupRepositoryImpl implements GroupRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, GroupHomeResponse>> getGroupHome() async {
    try {
      final response = await _restClient.get(url: Apis.groupHome);
      final data = await compute(parseResponse, response as String);
      return Right(data);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, GroupSectionsResponse>> getGroupSections() async {
    try {
      final response = await _restClient.get(url: Apis.groupSections);
      final data = await compute(parseSection, response as String);
      return Right(data);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, GroupJoinResponse>> joinGroup(GroupJoinRequest req, bool isLeave) async {
    try {
      final response = await _restClient.post(url: isLeave ? Apis.groupLeave : Apis.groupJoin,request: req.toJson());
      return Right(groupJoinResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, IntersetDetailResponse>> interestDetail(String interest,Map<String,dynamic> request) async {
    try {
      final response = await _restClient.get(url: "${Apis.interestsDetail}/$interest/discover",params: request);
      return Right(intersetDetailResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

