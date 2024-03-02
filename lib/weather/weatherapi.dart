import 'package:flutter/material.dart';
import 'package:flightsky/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String weatherDescription = '';
  String weatherMain = '';
  final List<String> weatherConditions = [
    'Thunderstorms',
    'Heavy snow',
    'Freezing rain',
    'Fog',
    'Strong crosswinds',
    'Severe turbulence',
    'Hurricanes or tropical storms',
  ];

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      // Fetching coordinates
      List<double> coordinates = await getCoordinates();
      double latitude = coordinates[0];
      double longitude = coordinates[1];

      WeatherData weatherData = await getCurrentWeather(latitude, longitude);
      setState(() {
        weatherDescription = weatherData.description;
        weatherMain = weatherData.main;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  // Mock function for getting coordinates
  Future<List<double>> getCoordinates() async {
    // You can implement your logic here to get coordinates, for example, using location plugins.
    // For the sake of example, I'm just returning hardcoded coordinates.
    return [40.7128, -74.0060];
  }

  @override
  Widget build(BuildContext context) {
    bool isWeatherDescriptionPresent =
        weatherDescription.isNotEmpty && weatherConditions.contains(weatherDescription);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (weatherMain.isNotEmpty)
            if (!isWeatherDescriptionPresent)
              const Text(
                'Flight is likely to proceed as scheduled.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              Text(
                'Weather : $weatherMain',
                style: TextStyle(fontSize: 24),
              ),
            if (isWeatherDescriptionPresent)
              const Text(
                'Flight may get canceled!',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            
          ],
        ),
      ),
    );
  }
}
