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
    update([ControllerBuilders.townHallLoading]);
    var data = await townHallRepositoryImpl.getData();
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.townHallLoading]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          townHallData = r.data;
          isLoading = false;
          update([
            ControllerBuilders.townHallLoading,
            ControllerBuilders.townHallHero,
            ControllerBuilders.townHallBrief,
            ControllerBuilders.townHallImpact,
            ControllerBuilders.townHallBills,
            ControllerBuilders.townHallMeeting,
            ControllerBuilders.townHallPriorities,
            ControllerBuilders.townHallRepresentatives,
            ControllerBuilders.townHallEngagement,
            ControllerBuilders.townHallProjects,
            ControllerBuilders.townHallTransparency,
            ControllerBuilders.townHallSentiment,
            ControllerBuilders.townHallPoll,
          ]);
        } else {
          isLoading = false;
          update([ControllerBuilders.townHallLoading]);
        }
      },
    );
  }
}
