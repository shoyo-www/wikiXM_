import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/request/login_request.dart';
import '../../data/datasource/remote/models/response/login_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginParams);

}
