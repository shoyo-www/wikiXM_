import 'dart:async';

import 'package:get/get.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/Repository_impl/home_repository_impl.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_local.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_response.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_alerts.dart';

import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/home_cat.dart';
import '../../data/datasource/remote/models/response/search_town.dart';

class DashboardController extends GetxController {
  bool isLoading = false;
  RxInt tabIndex = 0.obs;
  final HomeRepositoryImpl homeRepository = HomeRepositoryImpl();
  HomeData? homeData;
  HomeCatData? homeCatData;
  HomeLocalData? homeLocalData;
  WeatherData? weatherData;
  List<Town>? towns = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getHomeData(),
      getWeatherAlerts(),
      getHomeInterest(),
      getHomeLocal()]);
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> getHomeData() async {
    isLoading = true;
    update([ControllerBuilders.homeController]);
    var data = await homeRepository.getHomeData();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        homeData = r.data;
        LocalStorage.writeString(GetXStorageConstants.townName, r.data?.heroBanner?.location?.name ?? '');
        isLoading = false;
        update([ControllerBuilders.homeController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
    });
  }

  Future<void> getHomeInterest() async {
    var data = await homeRepository.getHomeInterests();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.homeSectionsController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        homeCatData = r.data;
        update([ControllerBuilders.homeSectionsController]);
      } else {
        update([ControllerBuilders.homeSectionsController]);
      }
    });
  }

  Future<void> getHomeLocal() async {
    var data = await homeRepository.getHomeLocal();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.homeSectionsController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        homeLocalData = r.data;
        update([ControllerBuilders.homeSectionsController]);
      } else {
        update([ControllerBuilders.homeSectionsController]);
      }
    });
  }

  Future<void> searchTowns(String town) async {
    isLoading = true;
    update([ControllerBuilders.searchTownController]);
    var data = await homeRepository.searchTown(town);
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.searchTownController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        towns = r.body?.towns ?? [];
        isLoading = false;
        update([ControllerBuilders.searchTownController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.searchTownController]);
      }
    });
  }

  Future<void> getWeatherAlerts() async {
    isLoading = true;
    update([ControllerBuilders.homeController]);
    var data = await homeRepository.getWeatherAlerts(46820, 'city');
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
    }, (r) {
      bool status = r.success ?? false;
      if (status == true) {
        weatherData = r.data;
        isLoading = false;
        update([ControllerBuilders.homeController]);
      } else {
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
    });
  }

  int relativeTimeWeight(String? value) {
    if (value == null || value.isEmpty) return 999999999;

    value = value.toLowerCase();

    final number = int.tryParse(value.split(' ').first) ?? 0;

    if (value.contains('second')) return number;
    if (value.contains('minute')) return 60 + number;
    if (value.contains('hour')) return 3600 + number;
    if (value.contains('day')) return 86400 + number;
    if (value.contains('week')) return 604800 + number;
    if (value.contains('month')) return 2629800 + number;
    if (value.contains('year')) return 31557600 + number;

    return 999999999;
  }

  String time(String? value) {
    if (value == null || value.isEmpty) return '';

    value = value.toLowerCase().trim();

    if (value.contains('year')) return '${value.split(' ').first}y';
    if (value.contains('month')) return '${value.split(' ').first}m';
    if (value.contains('week')) return '${value.split(' ').first}w';
    if (value.contains('day')) return '${value.split(' ').first}d';
    if (value.contains('hour')) return '${value.split(' ').first}h';
    if (value.contains('minute')) return '${value.split(' ').first}m';
    if (value.contains('second')) return '${value.split(' ').first}s';

    return value;
  }

}