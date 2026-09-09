import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/request/register.dart';
import 'package:wikixm/data/datasource/remote/models/request/resend_otp.dart';
import 'package:wikixm/data/datasource/remote/models/request/save_cities_request.dart';
import 'package:wikixm/data/datasource/remote/models/request/verify_otp.dart';
import 'package:wikixm/data/datasource/remote/models/response/personalisation_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/register_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/resend_otp.dart';
import 'package:wikixm/data/datasource/remote/models/response/save_cities_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/verify_otp.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/request/login_request.dart';
import '../../data/datasource/remote/models/request/personlisation_request.dart';
import '../../data/datasource/remote/models/response/complete_registration.dart';
import '../../data/datasource/remote/models/response/login_response.dart';
import '../../data/datasource/remote/models/response/search_town_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginParams);
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest req);
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest req);
  Future<Either<Failure, ResendResponse>> resendOtp(ResendOtpRequest req);
  Future<Either<Failure, SearchCityResponse>> searchCity(String town);
  Future<Either<Failure, SaveCitiesResponse>> saveCities(SaveCitiesRequest req);
  Future<Either<Failure, PersonalisationResponse>> getPersonalisation();
  Future<Either<Failure, CompleteRegistrationResponse>> completeRegistration(CompleteRegistrationRequest req);

}
