import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/request/no_params_req.dart';
import 'package:wikixm/data/datasource/remote/models/response/common_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/draft_item_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/image_analyse.dart';
import 'package:wikixm/data/datasource/remote/models/response/image_upload_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_brief_ai.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_brief_charts.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_filters.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_place.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_place_content.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_AI.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_dashboard.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/request/image_upload.dart';
import '../../data/datasource/remote/models/response/market_brief.dart';

abstract class GarageRepository {
  Future<Either<Failure, CreateItemDraft>> draft(NoParamsRequest request);
  Future<Either<Failure, ImageUploadResponse>> uploadImage(FileUploadRequest request,int itemId);
  Future<Either<Failure, CommonResponse>> deleteImage(int itemId,int imageId);
  Future<Either<Failure, ImageAnalyseResponse>> analyseImage(int itemId);
  Future<Either<Failure, MarketBriefResponse>> marketBrief(int cityId);
  Future<Either<Failure, MarketAiBriefResponse>> marketAiBrief(int cityId);
  Future<Either<Failure, MarketBriefChartsResponse>> marketBriefCharts(int cityId,int months);
  Future<Either<Failure, MarketPlaceResponse>> marketPlace(Map<String, dynamic> params);
  Future<Either<Failure, MarketPlaceContentResponse>> marketPlaceContent(int cityId);
  Future<Either<Failure, MarketPlaceFiltersResponse>> marketPlaceFilters(int cityId);
  Future<Either<Failure, MyGarageDashboardResponse>> myGarage();
  Future<Either<Failure, MyGarageAiResponse>> myGarageAI();
}