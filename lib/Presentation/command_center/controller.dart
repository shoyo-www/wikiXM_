import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/command_center_repository_impl.dart';

import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/command_center_response.dart';

class CommandCenterController extends GetxController {
  bool isLoading = false;
  final CommandCenterRepositoryImpl commandCenterRepositoryImpl = CommandCenterRepositoryImpl();
  CommandCenterData? commandCenterData;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isLoading = true;
    update([ControllerBuilders.commandCenterController]);
    var data = await commandCenterRepositoryImpl.getData();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.commandCenterController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        commandCenterData = r.data;
        isLoading = false;
        update([ControllerBuilders.commandCenterController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.commandCenterController]);
      }
    });
  }
}