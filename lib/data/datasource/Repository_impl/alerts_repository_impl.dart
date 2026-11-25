import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/remote/models/response/alert_categories.dart';
import 'package:wikixm/data/datasource/remote/models/response/alerts_home.dart';
import 'package:wikixm/data/datasource/remote/models/response/incident_detail.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';
import 'package:wikixm/domain/Repository/alerts_repository.dart';
import '../../../core/error/exceptions.dart';
import '../remote/services/apis.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, AlertsHomeResponse>> alertsHome(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.alertsHome, params: {"city_id": cityId});
      return Right(alertsHomeResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      // parse errors (bad JSON types) would otherwise leave the screen loading forever
      return const Left(ServerFailure(null));
    }
  }

  @override
  Future<Either<Failure, IncidentDetailResponse>> incidentDetail(int id) async {
    try {
      final response = await _restClient.get(url: '${Apis.incidents}$id');
      return Right(incidentDetailResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure(null));
    }
  }

  @override
  Future<Either<Failure, IncidentContentResponse>> incidentContent(int id, String type, {int? parentId, int? questionId}) async {
    try {
      final response = await _restClient.get(url: '${Apis.incidents}$id/content', params: {"type": type, "parent_id": ?parentId, "question_id": ?questionId});
      return Right(incidentContentResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure(null));
    }
  }

  @override
  Future<Either<Failure, AlertCategoriesResponse>> alertCategories(int cityId) async {
    try {
      final response = await _restClient.get(url: Apis.alertCategories, params: {"city_id": cityId});
      return Right(alertCategoriesResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure(null));
    }
  }

  @override
  Future<Either<Failure, CategoryIncidentsResponse>> categoryIncidents(int cityId, {required String category, required String phase, String sort = 'recent', int page = 1, int perPage = 10}) async {
    try {
      final response = await _restClient.get(url: Apis.categoryIncidents, params: {"city_id": cityId, "category": category, "phase": phase, "sort": sort, "page": page, "per_page": perPage});
      return Right(categoryIncidentsResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure(null));
    }
  }
}
