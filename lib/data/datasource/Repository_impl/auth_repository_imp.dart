import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/Repository/auth_repository.dart';
import '../remote/models/request/login_request.dart';
import '../remote/models/response/login_response.dart';
import '../remote/services/apis.dart';
import '../remote/services/dio/rest_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginParams) async {
    try {
      final response = await _restClient.post(
          url: Apis.login, request: loginParams.toJson());
      return Right(loginResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}
