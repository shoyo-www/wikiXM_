import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';
import '../../core/error/failures.dart';

abstract class SportsRepository {
  Future<Either<Failure, SportSectionResponse>> getSportsData();

}