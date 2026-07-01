import 'package:get/get.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import '../Presentation/getx/internet_controller.dart';
import '../data/datasource/remote/services/dio/rest_client.dart';

class InitialBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(RestClient(), permanent: true);
    Get.put(DashboardController(), permanent: true);
    Get.put(ConnectivityController(),permanent: true);
  }
}