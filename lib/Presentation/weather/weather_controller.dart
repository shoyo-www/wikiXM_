import 'package:get/get.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/Repository_impl/weather_repository_impl.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_hero_response.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/weather_card_response.dart';

class WeatherController extends GetxController {
  bool isLoading = true;
  bool closeAlert = true;
  final WeatherRepositoryImpl weatherRepositoryImpl = WeatherRepositoryImpl();
  WeatherHeroData? weatherHeroData;
  WeatherCardData? weatherCardData;

  @override
  void onInit() {
    getWeatherHero();
    super.onInit();
  }

  Future<void> getWeatherHero() async {
    isLoading = true;
    update([ControllerBuilders.weatherController]);
    var data = await weatherRepositoryImpl.getWeatherHero();
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.weatherController]);
        }
      },
      (r) async {
        bool status = r.success ?? false;
        if (status == true) {
          weatherHeroData = r.data;
          isLoading = false;
          await getWeatherCards();
          update([ControllerBuilders.weatherController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.weatherController]);
        }
      },
    );
  }

  Future<void> getWeatherCards() async {
    var data = await weatherRepositoryImpl.getWeatherCards();
    data.fold(
      (l) {
        if (l is ServerFailure) {}
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          weatherCardData = r.data;
        } else {}
      },
    );
  }
}
