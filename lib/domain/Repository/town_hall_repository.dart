import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/town_hall_response.dart';
import '../../core/error/failures.dart';

abstract class TownHallRepository {
  Future<Either<Failure, TownHallResponse>> getData();

}