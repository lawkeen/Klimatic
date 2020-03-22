import 'dart:ui';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/api.dart';
import 'package:weather_3/blocs/weatherBloc.dart';
import '../blocs/newCity.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _bloc = WeatherBloc();

  static String cityEntered = Api.defaultCity;


  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
        new MaterialPageRoute<Map<dynamic, dynamic>>(
            builder: (BuildContext context) {
      return new ChangeCity();
    }));

    if (results != null && results.containsKey('enter')) {
      cityEntered = results['enter'];
    }
  }

  var data = [0.3, 1.0, 1.5, 1.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Klimatic'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                _goToNextScreen(context);
              }),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              width: 750,
              height: 280,
              color: Colors.teal,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/back.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 85 + 100.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 85,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 250,
                          height: 200,
                          child: StreamBuilder<WeatherState>(
                            stream: _bloc.watchWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                WeatherState weatherState =
                                    snapshot.data ?? WeatherLoadingState();
                                return new Container(
                                  child: new Column(
                                    children: <Widget>[
                                      new ListTile(
                                        title: new Text(
                                          weatherState.weather.temperature
                                                  .toString() +
                                              '°',
                                          style: TextStyle(
                                            fontSize: 75,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return new Container();
                              }
                            },
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: StreamBuilder<WeatherState>(
                            stream: _bloc.watchWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                print(snapshot.data);
                                WeatherState weatherState =
                                    snapshot.data ?? WeatherLoadingState();
                                return new Container(
                                  child: new Column(
                                    children: <Widget>[
                                      new ListTile(
                                        title: new Text(
                                  '${HomePageState.cityEntered == null ? Api.defaultCity : cityEntered} | ' +
                                      weatherState.weather.state,
                                          style: TextStyle(
                                            fontSize: 75,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return new Container();
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Wind NW",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 50,
                                  child: StreamBuilder<WeatherState>(
                                    stream: _bloc.watchWeather,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                        WeatherState weatherState =
                                            snapshot.data ??
                                                WeatherLoadingState();
                                        return new Container(
                                          child: new Column(
                                            children: <Widget>[
                                              new ListTile(
                                                title: new Text(
                                                  weatherState.weather.wind
                                                          .toString() +
                                                      'm/s',
                                                  style: TextStyle(
                                                    fontSize: 75,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return new Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.white,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 50,
                                  child: StreamBuilder<WeatherState>(
                                    stream: _bloc.watchWeather,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                        WeatherState weatherState =
                                            snapshot.data ??
                                                WeatherLoadingState();
                                        return new Container(
                                          child: new Column(
                                            children: <Widget>[
                                              new ListTile(
                                                title: new Text(
                                                  weatherState.weather.humidity
                                                          .toString() +
                                                      '%',
                                                  style: TextStyle(
                                                    fontSize: 75,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return new Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Pressure",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 50,
                                  child: StreamBuilder<WeatherState>(
                                    stream: _bloc.watchWeather,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                        WeatherState weatherState =
                                            snapshot.data ??
                                                WeatherLoadingState();
                                        return new Container(
                                          child: new Column(
                                            children: <Widget>[
                                              new ListTile(
                                                title: new Text(
                                                  weatherState.weather.pressure
                                                          .toString() +
                                                      'mPa',
                                                  style: TextStyle(
                                                    fontSize: 75,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return new Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.white,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Feels like",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 50,
                                  child: StreamBuilder<WeatherState>(
                                    stream: _bloc.watchWeather,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data is WeatherLoadedState) {
                                        WeatherState weatherState =
                                            snapshot.data ??
                                                WeatherLoadingState();
                                        return new Container(
                                          child: new Column(
                                            children: <Widget>[
                                              new ListTile(
                                                title: new Text(
                                                  weatherState.weather.feelsLike
                                                          .toString() +
                                                      '°',
                                                  style: TextStyle(
                                                    fontSize: 75,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return new Container();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'HOURLY FORECAST',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Container(
              height: 120,
              child: Stack(
                children: <Widget>[
                  ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => _downfallCard(
                        percent:
                            double.parse((index * 1).toStringAsPrecision(1)),
                        downfallSpeed: 3),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                height: 200,
                child: new Sparkline(
                  data: data,
                  pointsMode: PointsMode.all,
                  pointSize: 8.0,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Container(
              height: 35,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Now",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "12:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "13:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "14:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "15:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "16:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "17:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "18:00",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "12 Jul, Wed",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _downfallCard({@required double percent, @required int downfallSpeed}) =>
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '$percent%',
              ),
              Icon(
                Icons.beach_access,
                size: 12,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
          SizedBox(height: 1),
          Container(
            width: 20,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.lightBlueAccent.withOpacity(0.7),
                  Colors.grey.withOpacity(0.2),
                ],
                stops: [percent * 0.01, percent * 0.01],
              ),
            ),
          ),
          SizedBox(height: 3),
          Row(
            children: <Widget>[
              Text(
                '${downfallSpeed}m/s',
              ),
              Icon(
                Icons.explore,
                size: 12,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ],
      );
}
