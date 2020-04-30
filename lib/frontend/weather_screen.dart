import 'package:weatherApp/backend/weather.dart';
import 'package:flutter/material.dart';
import 'package:weatherApp/backend/time.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';
  var now = DateTime.now();

  void updateUI() async {
    await weather.updateWeather();
    setState(() {
      if (weather == null) {
        temperature = 0;
        cityName = 'missing city';
        weatherMessage = 'missing message';
      } else {
        temperature = weather.getTemp();
        cityName = weather.getCityName();
        weatherMessage = weather.getWeatherMessage();
        now = DateTime.now();
      }
    });
  }

  IconData decideIcon() {
    return Icons.wb_sunny;
  }

  @override
  void initState() {
    super.initState();
    updateUI();
    print(weather.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                      '$temperature',
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
                      cityName,
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
                      weatherMessage,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    decideIcon(),
                    size: 150.0,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onVerticalDragStart: (dragDetails) {
        print("drag");
        updateUI();
      },
    );
  }
}

// credit Smashicons
