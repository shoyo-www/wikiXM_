import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/activiyt_detail.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_detail.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import 'package:wikixm/data/datasource/remote/models/response/interest_detail.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/group_repository.dart';
import '../../../core/error/exceptions.dart';
import '../remote/models/response/group_home.dart';
import '../remote/models/response/my_group_summary.dart';
import '../remote/models/response/activity_profile.dart';
import '../remote/models/response/my_group_list.dart';
import '../remote/models/response/my_group_attention.dart';
import '../remote/models/response/my_group_invitations.dart';
import '../remote/models/response/my_group_activities.dart';
import '../remote/models/response/my_group_settings.dart';
import '../remote/models/response/search_group.dart';
import '../remote/models/response/search_group_overview.dart';
import '../remote/services/apis.dart';

GroupHomeResponse parseResponse(String response) {
  return groupHomeResponseFromJson(response);
}

GroupSectionsResponse parseSection(String response) {
  return groupSectionsResponseFromJson(response);
}

SearchGroupResponse parseDiscoverGroups(String response) => searchGroupResponseFromJson(response);

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
      final response = await _restClient.post(url: isLeave ? Apis.groupLeave : Apis.groupJoin, request: req.toJson());
      return Right(groupJoinResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, IntersetDetailResponse>> interestDetail(String interest, Map<String, dynamic> request) async {
    try {
      final response = await _restClient.get(url: "${Apis.interestsDetail}/$interest/discover", params: request);
      return Right(intersetDetailResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupDetailResponse>> groupDetail(String id, Map<String, dynamic> request) async {
    try {
      final response = await _restClient.get(url: "${Apis.groupDetail}$id/content", params: request);
      return Right(groupDetailResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupActivityResponse>> activityDetail(String id,Map<String, dynamic> params) async {
    try {
      final response = await _restClient.get(url: "${Apis.activityDetail}$id", params: params);
      return Right(groupActivityResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupSummaryResponse>> myGroupSummary() async {
    try {
      final response = await _restClient.get(url: Apis.myGroupSummary);
      return Right(myGroupSummaryResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupListResponse>> myGroupList(String url, Map<String, dynamic> params) async {
    try {
      final response = await _restClient.get(url: url, params: params);
      return Right(myGroupListResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupAttentionResponse>> myGroupAttention(int page) async {
    try {
      final response = await _restClient.get(url: Apis.myAttention, params: {'page': page});
      return Right(myGroupAttentionResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityProfileResponse>> activityProfile() async {
    try {
      final response = await _restClient.get(url: Apis.activityProfile);
      return Right(activityProfileResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupActivitiesResponse>> myGroupActivities(int page) async {
    try {
      final response = await _restClient.get(url: Apis.myActivities, params: {'page': page, 'per_page': 12});
      return Right(myGroupActivitiesResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupSettingsResponse>> getMyGroupSettings() async {
    try {
      final response = await _restClient.get(url: Apis.myGroupSettings);
      return Right(myGroupSettingsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupSettingsResponse>> saveMyGroupSettings(bool recommendations) async {
    try {
      final response = await _restClient.put(url: Apis.myGroupSettings, request: {'recommendations': recommendations});
      return Right(myGroupSettingsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyGroupInvitationsResponse>> myGroupInvitations() async {
    try {
      final response = await _restClient.get(url: Apis.myInvitations);
      return Right(myGroupInvitationsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // shortcut: reads only "success", parse a model once the respond response shape is known.
  @override
  Future<Either<Failure, bool>> respondInvitation(int invitationId, bool accepted) async {
    try {
      final response = await _restClient.put(url: Apis.respondInvitation, request: {'id': invitationId, 'accepted': accepted});
      final body = response is String ? json.decode(response) : response;
      return Right(body is Map && body['success'] == true);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchGroupOverviewResponse>> discoverOverview(int townId) async {
    try {
      final response = await _restClient.get(url: Apis.discoverOverview, params: {'town_id': townId});
      return Right(searchGroupOverviewResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // parsed off the UI thread: a page of 12 items with long "searchable" text would stall a frame while scrolling
  @override
  Future<Either<Failure, SearchGroupResponse>> discoverGroups(Map<String, dynamic> params) async {
    try {
      final response = await _restClient.get(url: Apis.groupList, params: params);
      return Right(await compute(parseDiscoverGroups, response as String));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
