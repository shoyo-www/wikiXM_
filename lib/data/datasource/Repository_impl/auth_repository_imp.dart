import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/remote/models/request/personlisation_request.dart';
import 'package:wikixm/data/datasource/remote/models/request/register.dart';
import 'package:wikixm/data/datasource/remote/models/request/resend_otp.dart';
import 'package:wikixm/data/datasource/remote/models/request/save_cities_request.dart';
import 'package:wikixm/data/datasource/remote/models/request/verify_otp.dart';
import 'package:wikixm/data/datasource/remote/models/response/complete_registration.dart';
import 'package:wikixm/data/datasource/remote/models/response/personalisation_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/register_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/resend_otp.dart';
import 'package:wikixm/data/datasource/remote/models/response/save_cities_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/verify_otp.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/Repository/auth_repository.dart';
import '../remote/models/request/login_request.dart';
import '../remote/models/response/login_response.dart';
import '../remote/models/response/search_town_response.dart';
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

  @override
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.register, request: req.toJson());
      return Right(registerResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.verifyOtp, request: req.toJson());
      return Right(verifyOtpResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResendResponse>> resendOtp(ResendOtpRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.resendOtp, request: req.toJson());
      return Right(resendResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SearchCityResponse>> searchCity(String town) async {
    try {
      final response = await _restClient.get(url: Apis.searchTowns,params: {"q" : town});
      return Right(searchCityResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SaveCitiesResponse>> saveCities(SaveCitiesRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.saveCities, request: req.toJson());
      return Right(saveCitiesResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PersonalisationResponse>> getPersonalisation() async {
    try {
      final response = await _restClient.get(url: Apis.personalisation);
      return Right(personalisationResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CompleteRegistrationResponse>> completeRegistration(CompleteRegistrationRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.completeRegistration, request: req.toJson());
      return Right(completeRegistrationResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}
