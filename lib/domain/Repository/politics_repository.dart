import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/politics_response.dart';
import '../../core/error/failures.dart';

abstract class PoliticsRepository {
  Future<Either<Failure, PoliticsResponse>> getPoliticsData();

}