import 'package:weatherApp/backend/location.dart';
import 'package:weatherApp/backend/network.dart';

const apiKey = '8a9713afca1ce19dba4b3bf6c1beeed4';
// https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&appid={YOUR API KEY}

class WeatherModel {
  String temperature;
  String cityName;
  String weatherMessage;
  int weatherID = 800;
  String humidity;
  String pressure;
  String uvi;
  String wind;
  var weatherData;

  void updateWeather() async {
    this.weatherData = await getWeather();
    setValues(this.weatherData);
  }

  Future<dynamic> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print("location is: ${weatherData['timezone'].toString()}");
    return weatherData;
  }

  void setValues(dynamic weatherData) {
    this.cityName = weatherData['timezone'].toString();
    this.temperature = weatherData['current']['temp'].round().toString();
    this.weatherMessage = weatherData['current']['weather'][0]['description'];
    this.weatherID = weatherData['current']['weather'][0]['id'];
  }

  String getTemp() {
    return this.temperature;
  }

  String getCityName() {
    return this.cityName;
  }

  String getWeatherMessage() {
    return this.weatherMessage;
  }

  int getWeatherID() {
    return this.weatherID;
  }
}
