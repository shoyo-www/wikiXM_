import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/sports_repository_impl.dart';

import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/sports_response.dart';

class SportsController  extends GetxController{
  bool isLoading = false;
  final SportsRepositoryImpl sportsRepositoryImpl = SportsRepositoryImpl();
  SportsData? sportsData;

  @override
  void onInit() {
    super.onInit();
    getSportsData();
  }

  Future<void> getSportsData() async {
    isLoading = true;
    update([ControllerBuilders.sportsController]);
    var data = await sportsRepositoryImpl.getSportsData();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.sportsController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        sportsData = r.data?.widgets;
        isLoading = false;
        update([ControllerBuilders.sportsController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.sportsController]);
      }
    });
  }

  int getActivityCount(String key) {
    final item = sportsData?.recentActivity?.items?.firstWhere(
          (item) => item.key == key,
      orElse: () => Item(
        key: key,
        label: '',
        count: 0,
      ),
    );

    return item?.count ?? 0;
  }

}