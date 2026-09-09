import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/Education_response.dart';
import '../../core/error/failures.dart';

abstract class EducationRepository {
  Future<Either<Failure, EducationHomeResponse>> getEducationData();

}