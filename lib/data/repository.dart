import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:weather_3/models/weather.dart';
import 'api.dart';

class Repository {
  static _WeatherData get weatherData => _WeatherData();
}

abstract class _HiveBoxData {
  init() async {
    await Hive.openBox('weatherData');
  }
}

class _WeatherData extends _HiveBoxData {
  update({@required ValueChanged<Weather> onData}) async {
    try {
      var weather = await Api.getWeather();
      if (weather != null) {
        await Hive.box('weatherData').putAll(weather.toMap);
      } else {
        if (Hive.box('weatherData').isEmpty) {
          await Hive.box('weatherData').putAll({
            'temperature': 0,
            'wind': 0,
            'humidity': 0,
            'pressure': 0,
            'feelsLike': 0,
            'location': '',
            'state': '',
          });
        }
      }
    } catch (e) {}
    onData(Weather(
      temperature: Hive.box('weatherData').get('temperature'),
      wind: Hive.box('weatherData').get('wind'),
      humidity: Hive.box('weatherData').get('humidity'),
      pressure: Hive.box('weatherData').get('pressure'),
      feelsLike: Hive.box('weatherData').get('feelsLike'),
      location: Hive.box('weatherData').get('location'),
      state: Hive.box('weatherData').get('state'),
    ));
  }
}
