import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/education_repository_impl.dart';

import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/Education_response.dart';

class SchoolController extends GetxController {
  bool isLoading = false;
  final EducationRepositoryImpl educationRepositoryImpl = EducationRepositoryImpl();
  EducationData? educationData;
  String selectedSchoolFilter = 'all';

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void changeSchoolFilter(String filterId) {
    selectedSchoolFilter = filterId;
    update([ControllerBuilders.schoolBrowse]);
  }

  Future<void> getData() async {
    isLoading = true;
    update([ControllerBuilders.schoolLoading]);
    var data = await educationRepositoryImpl.getEducationData();
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.schoolLoading]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          educationData = r.data;
          isLoading = false;
          update([
            ControllerBuilders.schoolLoading,
            ControllerBuilders.schoolHero,
            ControllerBuilders.schoolBrief,
            ControllerBuilders.schoolLive,
            ControllerBuilders.schoolMatters,
            ControllerBuilders.schoolToday,
            ControllerBuilders.schoolPulse,
            ControllerBuilders.schoolBrowse,
            ControllerBuilders.schoolTopics,
            ControllerBuilders.schoolBoard,
            ControllerBuilders.schoolSpotlight,
            ControllerBuilders.schoolEvents,
            ControllerBuilders.schoolMemories,
          ]);
        } else {
          isLoading = false;
          update([ControllerBuilders.schoolLoading]);
        }
      },
    );
  }
}
