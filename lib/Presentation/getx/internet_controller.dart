import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final _connectionType = MConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  MConnectivityResult get connectionType => _connectionType.value;

  set connectionType(MConnectivityResult value) {
    _connectionType.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnectivity();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateState(results);
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _updateState(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      connectionType = MConnectivityResult.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      connectionType = MConnectivityResult.mobile;
    } else {
      connectionType = MConnectivityResult.none;
    }
  }

  bool get isConnected => connectionType != MConnectivityResult.none;

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}

enum MConnectivityResult { none, wifi, mobile }