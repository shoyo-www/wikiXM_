import 'package:dio/dio.dart';

import 'dio/dio.dart';

class BaseNetworkClient {
  Dio get getNetworkClient => WebUtil.createDio();
}
