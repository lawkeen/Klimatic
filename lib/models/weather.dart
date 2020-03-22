class Weather {
  final double temperature;
  final double wind;
  final double humidity;
  final double pressure;
  final double feelsLike;
  final String location;
  final String state;

  Weather({
    this.temperature,
    this.wind,
    this.humidity,
    this.pressure,
    this.feelsLike,
    this.location,
    this.state,
  }) : assert(humidity >= 0 && humidity <= 100 ||
            temperature >= -100 && temperature <= 100 ||
            feelsLike >= -100 && feelsLike <= 100);

  get toMap => {
        'temperature': temperature,
        'wind': wind,
        'humidity': humidity,
        'pressure': pressure,
        'feelsLike': feelsLike,
        'location': location,
        'state': state,
      };
}
