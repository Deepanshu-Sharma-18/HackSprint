import 'dart:convert';

import 'package:flightsky/models/flightsapi.dart';
import 'package:flightsky/models/opensky.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FlighApiClient {
  var api_key = "65e2c9e332c0abbe7df4d2de";

  static const String baseUrl = "https://api.flightapi.io/airlines";

  Future<List<FlightsApi>?> fetchflightsData(
      int flightnum, String flightname) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/$api_key?num=$flightnum&name=$flightname&date=20231024');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return flightsApiFromJson(data);
      } else {
        // Handle error scenario
        if (kDebugMode) {
          print('Error fetching data: ${response.statusCode}');
        }
        return null;
      }
    } catch (error) {
      // Handle network or other exceptions
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
      return null;
    }
  }
}
