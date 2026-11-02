import 'package:get/get.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/Repository_impl/weather_repository_impl.dart';
import 'package:wikixm/data/datasource/remote/models/response/weather_hero_response.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/weather_card_response.dart';
import '../widgets/weather_animations.dart';

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

  /// The animated sky for the hero. scene_id is matched by keyword ("night-partly-cloudy", "heavy-rain", "clear-day", ...)
  /// together with weather_type and daypart, so ids the API adds later still land on a sensible scene.
  WeatherScene get weatherScene {
    final text = '${weatherHeroData?.sceneId ?? ''} ${weatherHeroData?.weatherType ?? ''}'.toLowerCase();
    final daypart = (weatherHeroData?.daypart ?? '').toLowerCase();
    final night = daypart == 'night' || text.contains('night');
    bool has(List<String> words) => words.any(text.contains);
    // snow before storm so "snowstorm" snows
    if (has(['snow', 'sleet', 'flurr', 'blizzard'])) return WeatherScene.snow(night: night);
    if (has(['thunder', 'storm', 'lightning'])) return WeatherScene.thunderstorm(night: night);
    if (has(['fog', 'mist', 'haze', 'smoke'])) return WeatherScene.fog(night: night);
    if (has(['rain', 'drizzle', 'shower'])) return WeatherScene.rain(night: night);
    if (has(['partly', 'scattered', 'few-clouds', 'mostly-sunny', 'mostly-clear'])) return WeatherScene.partlyCloudy(night: night);
    if (has(['cloud', 'overcast'])) return WeatherScene.cloudy(night: night);
    if (has(['sunrise', 'dawn']) || daypart == 'sunrise' || daypart == 'dawn') return WeatherScene.sunrise();
    if (has(['sunset', 'dusk']) || daypart == 'sunset' || daypart == 'dusk' || daypart == 'evening') return WeatherScene.sunset();
    return WeatherScene.clear(night: night);
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
          // show the hero and its animation now; the cards fill in when they arrive (every use is null-safe)
          update([ControllerBuilders.weatherController]);
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
