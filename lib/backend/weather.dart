import 'package:weatherApp/backend/location.dart';
import 'package:weatherApp/backend/network.dart';

const apiKey = '8a9713afca1ce19dba4b3bf6c1beeed4';
// https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&appid={YOUR API KEY}

class WeatherModel {
  int temperature = 100000;
  String cityName = 'Fake city';
  String weatherMessage = 'Fake message';

  void updateWeather() async {
    Location location = Location();
    await location
        .getCurrentLocation(); //updates current location in the location object
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print("this is data: " + weatherData['timezone']);
    setValues(weatherData);
  }

  void setValues(dynamic weatherData) {
    this.cityName = weatherData['timezone'].toString();
    this.temperature = weatherData['current']['temp'].round();
    this.weatherMessage = weatherData['current']['weather'][0]['description'];
  }

  int getTemp() {
    return this.temperature;
  }

  String getCityName() {
    return this.cityName;
  }

  String getWeatherMessage() {
    return this.weatherMessage;
  }
}
