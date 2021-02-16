import './location.dart';
import './networking.dart';
import './parser.dart';
import '../constants.dart';

class WeatherModel {
  static Future<Parser> getCityWeather(String city) async {
    Parser parser = await NetworkHelper()
        .getData("$kApiURL?units=metric&q=$city&appid=$KApiKEY");
    return parser;
  }

  static Future<Parser> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Parser parser = await NetworkHelper().getData(
        "$kApiURL?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$KApiKEY");

    return parser;
  }

  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
