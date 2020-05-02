import 'package:flutter/material.dart';
import 'package:weatherApp/backend/weather.dart';
import 'package:weatherApp/backend/time.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weather = WeatherModel();
  var now = DateTime.now();

  Icon decideIcon(int weatherID) {
    DateTime now = DateTime.now();
    if (now.hour < 6 || now.hour > 18) {
      if (weatherID > 800) {
        return Icon(
          Icons.filter_drama,
          size: 150.0,
          color: Colors.white,
        );
      } else if (weatherID == 800) {
        return Icon(
          Icons.brightness_2,
          size: 150.0,
          color: Colors.grey[100],
        );
      } else {
        // raining weather
        return Icon(
          Icons.beach_access,
          size: 150.0,
          color: Colors.blueAccent[900],
        );
      }
    } else {
      if (weatherID > 800) {
        return Icon(
          Icons.filter_drama,
          size: 150.0,
          color: Colors.white,
        );
      } else if (weatherID == 800) {
        return Icon(
          Icons.wb_sunny,
          size: 150.0,
          color: Colors.yellowAccent,
        );
      } else {
        // need to fix remaining icons later
        return Icon(
          Icons.beach_access,
          size: 150.0,
          color: Colors.blueAccent[900],
        );
      }
      return Icon(
        Icons.wb_sunny,
        size: 150.0,
        color: Colors.yellowAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
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
                        snapshot.data['current']['weather'][0]['description'],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: decideIcon(
                        snapshot.data['current']['weather'][0]['id']),
                  ),
                ],
              ),
            );
            ;
          } else if (snapshot.hasError) {
            return Text('error');
          } else {
            return Icon(
              Icons.autorenew,
              size: 200.0,
              color: Colors.white,
            );
          }
        }, // builder for the future
      ),
    );
  }
}
