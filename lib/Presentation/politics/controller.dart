import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/politics_repository_impl.dart';

import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/politics_response.dart';

class PoliticsController extends GetxController {
  bool isLoading = false;
  final PoliticsRepositoryImpl politicsRepositoryImpl = PoliticsRepositoryImpl();
  PoliticsData? politicsData;

  @override
  void onInit() {
    getPoliticsData();
    super.onInit();
  }

  Future<void> getPoliticsData() async {
    isLoading = true;
    update([ControllerBuilders.politicsController]);
    var data = await politicsRepositoryImpl.getPoliticsData();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.politicsController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        politicsData = r.data;
        isLoading = false;
        update([ControllerBuilders.politicsController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.politicsController]);
      }
    });
  }
}