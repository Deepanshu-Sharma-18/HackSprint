import 'package:dio/dio.dart';
import 'package:flightsky/constants.dart';

final String apiKey = "";

final dio = Dio();

class WeatherData {
  final String main;
  final String description;

  WeatherData({required this.main, required this.description});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      main: json['main'],
      description: json['description'],
    );
  }
}

Future<WeatherData> getCurrentWeather(double latitude, double longitude) async {
  try {
    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'appid': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> weatherList = data['weather'];
      if (weatherList.isNotEmpty) {
        final Map<String, dynamic> weatherData = weatherList[0];
        return WeatherData.fromJson(weatherData);
      } else {
        throw Exception('No weather data found');
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Request failed with error: $error');
  }
}
