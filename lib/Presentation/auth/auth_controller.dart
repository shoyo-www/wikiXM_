import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/auth_repository_imp.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import 'package:wikixm/data/datasource/remote/models/request/register.dart';
import 'package:wikixm/data/datasource/remote/models/request/resend_otp.dart';
import 'package:wikixm/data/datasource/remote/models/request/save_cities_request.dart';
import 'package:wikixm/data/datasource/remote/models/request/verify_otp.dart';

import '../../approutes.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/request/login_request.dart';
import '../../data/datasource/remote/models/request/personlisation_request.dart';
import '../../data/datasource/remote/models/response/personalisation_response.dart';
import '../../data/datasource/remote/models/response/register_response.dart';
import '../../data/datasource/remote/models/response/search_town_response.dart';

class AuthController extends GetxController {
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController searchTown = TextEditingController();
  TextEditingController secondarySearchTown = TextEditingController();
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  final formKey = GlobalKey<FormState>();
  final RxInt currentStep = 1.obs;
  final RxList<int> selectedCategories = <int>[].obs;
  final RxBool inAppNotification = false.obs;
  final RxBool emailNotification = false.obs;
  final RxBool smsNotification = false.obs;
  final RxInt remainingSeconds = 60.obs;
  final RxBool canResend = false.obs;
  final RxString fullNameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordValue = ''.obs;
  final RxString passwordError = ''.obs;
  final Rxn<SearchTowns> selectedPrimaryTown = Rxn<SearchTowns>();
  Timer? _timer;
  final RxList<SearchTowns> secondaryTowns = <SearchTowns>[].obs;
  RxString registerToken = ''.obs;
  RegisterData? registerData;
  RxString otp = ''.obs;
  RxList<SearchTowns> searchTownsList = <SearchTowns>[].obs;
  Timer? _debounce;
  final FocusNode searchFocus = FocusNode();
  final FocusNode secondarySearchFocus = FocusNode();
  final isSearching = false.obs;
  final showPrimarySearch = false.obs;
  final showSecondarySearch = false.obs;
  Rxn<PersonalisationData> personalisationData = Rxn();
  final RxList<int> selectedNotifications = <int>[].obs;

  void toggleNotification(int id) {
    if (selectedNotifications.contains(id)) {
      selectedNotifications.remove(id);
    } else {
      selectedNotifications.add(id);
    }
  }

  void onSearchChanged(String value, {bool isPrimary = true}) {
    _debounce?.cancel();

    if (value.trim().isEmpty) {
      searchTownsList.clear();
      _setSearchVisible(isPrimary, false);
      return;
    }

    _setSearchVisible(isPrimary, true);
    _debounce = Timer(const Duration(milliseconds: 350), () {
      searchTowns(isPrimary: isPrimary);
    });
  }

  bool validateCreateAccount() {
    fullNameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    bool isValid = true;
    if (fullName.text.trim().isEmpty) {
      fullNameError.value = 'Please enter your full name';
      isValid = false;
    }
    if (email.text.trim().isEmpty) {
      emailError.value = 'Please enter your email address';
      isValid = false;
    } else if (!GetUtils.isEmail(email.text.trim())) {
      emailError.value = 'Please enter a valid email address';
      isValid = false;
    }
    if (password.text.isEmpty) {
      passwordError.value = 'Please enter your password';
      isValid = false;
    } else if (password.text.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      isValid = false;
    } else if (!RegExp(r'[0-9]').hasMatch(password.text)) {
      passwordError.value = 'Password must contain at least one number';
      isValid = false;
    } else if (!RegExp(r'[A-Z]').hasMatch(password.text)) {
      passwordError.value = 'Password must contain at least one uppercase letter';
      isValid = false;
    }
    return isValid;
  }

  void startOtpTimer() {
    _timer?.cancel();
    remainingSeconds.value = 60;
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void selectTown(SearchTowns town) {
    selectedPrimaryTown.value = town;
    searchTown.clear();
    searchFocus.unfocus();
    secondaryTowns.removeWhere((item) => _sameTown(item, town));
    _hideSearch();
  }

  void clearPrimaryTown() {
    selectedPrimaryTown.value = null;
    secondaryTowns.clear();
    searchTown.clear();
    secondarySearchTown.clear();
    _hideSearch();
  }

  void selectSecondaryTown(SearchTowns town) {
    if (secondaryTowns.length >= 4 || _sameTown(town, selectedPrimaryTown.value) || secondaryTowns.any((item) => _sameTown(item, town))) {
      return;
    }
    secondaryTowns.add(town);
    secondarySearchTown.clear();
    secondarySearchFocus.unfocus();
    _hideSearch();
    update();
  }

  void removeSecondaryTown(SearchTowns town) {
    secondaryTowns.removeWhere((item) => _sameTown(item, town));
    update();
  }

  bool _sameTown(SearchTowns? a, SearchTowns? b) {
    if (a == null || b == null) return false;
    return a.cityId != null && b.cityId != null ? a.cityId == b.cityId : a.cityName == b.cityName && a.stateAbbreviation == b.stateAbbreviation;
  }

  void _setSearchVisible(bool isPrimary, bool visible) {
    if (isPrimary) {
      showPrimarySearch.value = visible;
    } else {
      showSecondarySearch.value = visible;
    }
  }

  void _hideSearch() {
    showPrimarySearch.value = false;
    showSecondarySearch.value = false;
    searchTownsList.clear();
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleCategory(int id) {
    if (selectedCategories.contains(id)) {
      selectedCategories.remove(id);
    } else {
      selectedCategories.add(id);
    }
  }

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    var req = LoginRequest(email: email.text, password: password.text);
    var data = await authRepositoryImpl.login(req);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading.value = false;
        }
      },
      (r) {
        int code = r.code ?? 0;
        if (code == 200) {
          LocalStorage.setAuthToken(r.token ?? '');
          Get.offAllNamed(AppRoutes.dashboard);
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      },
    );
  }

  Future<void> register() async {
    isLoading.value = true;
    final parts = fullName.text.trim().split(RegExp(r'\s+'));
    var request = RegisterRequest(email: email.text, firstName: parts.isNotEmpty ? parts.first : '', lastName: parts.length > 1 ? parts.sublist(1).join(' ') : '', password: password.text, passwordConfirmation: password.text, termsAccepted: 1);
    var data = await authRepositoryImpl.register(request);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading.value = false;
        }
      },
      (r) {
        bool code = r.success ?? false;
        if (code == true) {
          registerData = r.data;
          LocalStorage.writeString('rToken', r.data?.registrationToken ?? "");
          isLoading.value = false;
          startOtpTimer();
          nextStep();
        } else {
          isLoading.value = false;
        }
      },
    );
  }

  Future<void> verifyOtp() async {
    isLoading.value = true;
    var request = VerifyOtpRequest(identifier: registerData?.identifier ?? '', type: registerData?.type ?? '', purpose: registerData?.purpose ?? '', otp: otp.value);
    var data = await authRepositoryImpl.verifyOtp(request);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading.value = false;
        }
      },
      (r) {
        bool code = r.success ?? false;
        if (code == true) {
          registerToken.value = r.data?.registrationToken ?? '';
          isLoading.value = false;
          nextStep();
        } else {
          isLoading.value = false;
        }
      },
    );
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    var request = ResendOtpRequest(identifier: registerData?.identifier ?? '', type: registerData?.type ?? '', purpose: registerData?.purpose ?? '');
    var data = await authRepositoryImpl.resendOtp(request);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          Get.snackbar('Failed', l.message ?? 'Something went wrong', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, margin: const EdgeInsets.all(16), borderRadius: 8, duration: const Duration(seconds: 3));
        }
      },
      (r) {
        bool code = r.success ?? false;
        if (code == true) {
          startOtpTimer();
          Get.snackbar('Success', 'OTP sent successfully.');
        } else {}
      },
    );
  }

  Future<void> searchTowns({bool isPrimary = true}) async {
    final query = isPrimary ? searchTown.text : secondarySearchTown.text;
    if (query.trim().isEmpty) return;
    isSearching.value = true;
    var data = await authRepositoryImpl.searchCity(query);
    data.fold(
      (l) {
        isSearching.value = false;
        if (l is ServerFailure) {
          Get.snackbar('Failed', l.message ?? 'Something went wrong', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, margin: const EdgeInsets.all(16), borderRadius: 8, duration: const Duration(seconds: 3));
        }
      },
      (r) {
        isSearching.value = false;
        bool code = r.success ?? false;
        if (code == true) {
          searchTownsList.value = (r.data?.items ?? []).where((town) => isPrimary ? !secondaryTowns.any((item) => _sameTown(item, town)) : !_sameTown(town, selectedPrimaryTown.value) && !secondaryTowns.any((item) => _sameTown(item, town))).toList();
          _setSearchVisible(isPrimary, searchTownsList.isNotEmpty);
        } else {
          searchTownsList.clear();
          _setSearchVisible(isPrimary, false);
        }
      },
    );
  }

  Future<void> saveCities() async {
    isLoading.value = true;
    var req = SaveCitiesRequest(primaryTown: selectedPrimaryTown.value?.cityId ?? 0, secondaryTowns: secondaryTowns.map((e) => e.cityId!).toList());
    var data = await authRepositoryImpl.saveCities(req);
    data.fold(
      (l) {
        isSearching.value = false;
        if (l is ServerFailure) {
          isLoading.value = false;
          Get.snackbar('Failed', l.message ?? 'Something went wrong', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, margin: const EdgeInsets.all(16), borderRadius: 8, duration: const Duration(seconds: 3));
        }
      },
      (r) async {
        bool code = r.success ?? false;
        if (code == true) {
          await getPersonalisation();
          nextStep();
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      },
    );
  }

  Future<void> getPersonalisation() async {
    var data = await authRepositoryImpl.getPersonalisation();
    data.fold(
      (l) {
        isSearching.value = false;
        if (l is ServerFailure) {
          Get.snackbar('Failed', l.message ?? 'Something went wrong', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, margin: const EdgeInsets.all(16), borderRadius: 8, duration: const Duration(seconds: 3));
        }
      },
      (r) {
        bool code = r.success ?? false;
        if (code == true) {
          personalisationData.value = r.data;
        } else {}
      },
    );
  }

  Future<void> completeRegistration() async {
    isLoading.value = true;
    final request = CompleteRegistrationRequest(interests: selectedCategories.toList(), notifications: selectedNotifications.toList(), deliveryChannels: [1]);
    final result = await authRepositoryImpl.completeRegistration(request);
    result.fold(
      (l) {
        isLoading.value = false;
        if (l is ServerFailure) {
          Get.snackbar("Failed", l.message ?? "Something went wrong");
        }
      },
      (r) {
        isLoading.value = false;
        if (r.success == true) {
          LocalStorage.setAuthToken(r.data?.token ?? "");
          LocalStorage.clearValueByKey('rToken');
          Get.offAllNamed(AppRoutes.dashboard);
        } else {
          Get.snackbar("Failed", r.message ?? "Something went wrong");
        }
      },
    );
  }
}
