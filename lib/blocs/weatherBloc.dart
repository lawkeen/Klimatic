import 'package:rxdart/rxdart.dart';
import '../models/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/repository.dart';

class WeatherBloc {
  WeatherBloc() {
    _init();
  }

  final _weatherSubject = BehaviorSubject<WeatherState>();

  get watchWeather => _weatherSubject.stream;

  _init() async {
    await Repository.weatherData.init();

    update();
  }

  update() {
    _weatherSubject.sink.add(WeatherLoadingState());

    Repository.weatherData.update(
      onData: (data) => _weatherSubject.sink.add(
        WeatherLoadedState(weather: data),
      ),
    );
  }

  dispose() {
    _weatherSubject.close();
  }
}

abstract class WeatherState {
  final Weather weather;

  WeatherState(this.weather);
}

/// Weather state is loading.
class WeatherLoadingState extends WeatherState {
  WeatherLoadingState() : super(null);
}

/// Weather state is loaded.
class WeatherLoadedState extends WeatherState {
  WeatherLoadedState({@required weather}) : super(weather);
}
