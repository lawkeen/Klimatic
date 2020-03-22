import 'package:http/http.dart' as http;
import 'package:weather_3/models/weather.dart';
import 'dart:convert';

class Api {
  static final appId = 'c6042b7fa6f3a6104fae8682375ba55d';
  static final defaultCity = "Ulyanovsk";

  static Future<Weather> getWeather() async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$defaultCity&appid='
        '$appId&units=metric';

    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      Map content = jsonDecode(response.body);

      return Weather(
        temperature: content['main']['temp'].round(),
        wind: content['wind']['speed'].round(),
        humidity: content['main']['humidity'],
        feelsLike: content['main']['feels_like'].round(),
        pressure: content['main']['pressure'],
        location: defaultCity,
        state: content['weather'][0]['main'],
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
