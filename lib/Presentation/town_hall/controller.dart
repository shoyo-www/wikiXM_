import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/town_hall_repository_impl.dart';

import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/town_hall_response.dart';

class TownHallController extends GetxController {
  bool isLoading = false;
  final TownHallRepositoryImpl townHallRepositoryImpl = TownHallRepositoryImpl();
  TownHallData? townHallData;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isLoading = true;
    update([ControllerBuilders.townHallController]);
    var data = await townHallRepositoryImpl.getData();
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.townHallController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          townHallData = r.data;
          isLoading = false;
          update([ControllerBuilders.townHallController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.townHallController]);
        }
      },
    );
  }
}
