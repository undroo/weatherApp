import 'package:flutter/material.dart';
import 'package:weatherApp/frontend/forecast_screen.dart';
import 'package:weatherApp/frontend/new_weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  Widget pickDisplay() {
    if (selectedIndex == 1) {
      return Expanded(
        child: ForecastScreen(),
      );
    }
    return Expanded(
      child: WeatherScreen(),
    );
  }

  Color backgroundColor() {
    DateTime now = DateTime.now();
    if (now.hour < 6 || now.hour > 18) {
      return Colors.deepPurpleAccent[100];
    } else {
      return Colors.lightBlueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      body: SafeArea(
        child: PageView(
          controller: PageController(
            initialPage: 0,
          ),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            WeatherScreen(),
            ForecastScreen(),
          ],
        ),
      ),
    );
  }
}
