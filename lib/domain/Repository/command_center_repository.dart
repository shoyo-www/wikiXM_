import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/response/command_center_response.dart';
import '../../core/error/failures.dart';

abstract class CommandCenterRepository {
  Future<Either<Failure, CommandCenterResponse>> getData();

}