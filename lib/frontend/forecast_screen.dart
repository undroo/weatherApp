import 'package:flutter/material.dart';
import 'package:weatherApp/backend/weather.dart';
import 'package:weatherApp/backend/time.dart';

class ForecastScreen extends StatefulWidget {
  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  WeatherModel weather = WeatherModel();
  var weatherData;
  var now = DateTime.now();

  Future<dynamic> updateUI() async {
    var data = await weather.getWeather();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: weather.getWeather(),
            builder: (context, snapshot) {
              //snapshot.data is the 'weatherData' and holds all the info from getWeather()
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // replace this column with a card class
                      Column(
                        children: <Widget>[
                          Text(
                            fullTime(now),
                            style: TextStyle(
                              fontSize: 20.0,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 1.0,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                          Text(
                            snapshot.data['current']['temp'].round().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 150.0,
                              fontWeight: FontWeight.w300,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.5, 2.5),
                                  blurRadius: 1.0,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                          Text(
                            snapshot.data['timezone'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 1.0,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                          Text(
                            snapshot.data['current']['weather'][0]
                                ['description'],
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 1.0,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ],
                  ),
                );
                ;
              } else if (snapshot.hasError) {
                return Text('error');
              } else {
                return Icon(
                  Icons.refresh,
                  size: 200.0,
                  color: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
