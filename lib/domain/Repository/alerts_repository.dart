import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/alert_categories.dart';
import 'package:wikixm/data/datasource/remote/models/response/alerts_home.dart';
import 'package:wikixm/data/datasource/remote/models/response/incident_detail.dart';
import '../../core/error/failures.dart';

abstract class AlertsRepository {
  Future<Either<Failure, AlertsHomeResponse>> alertsHome(int cityId);
  Future<Either<Failure, IncidentDetailResponse>> incidentDetail(int id);
  Future<Either<Failure, IncidentContentResponse>> incidentContent(int id, String type, {int? parentId, int? questionId});
  Future<Either<Failure, AlertCategoriesResponse>> alertCategories(int cityId);
  Future<Either<Failure, CategoryIncidentsResponse>> categoryIncidents(int cityId, {required String category, required String phase, String sort = 'recent', int page = 1, int perPage = 10});
}
