import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/auth_repository_imp.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';

import '../../approutes.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/request/login_request.dart';

class AuthController extends GetxController {
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    isLoading.value = true;
    var req = LoginRequest(email: email.text,  password: password.text);
    var data = await authRepositoryImpl.login(req);
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading.value = false;
      }
    }, (r) {
      int code = r.code ?? 0;
      if (code == 200) {
        LocalStorage.setAuthToken(r.token ?? '');
        Get.offAllNamed(AppRoutes.dashboard);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }
}