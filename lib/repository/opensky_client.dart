import 'dart:convert';

import 'package:flightsky/models/opensky.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OpenSkyClient {
  static const String baseUrl =
      'https://api.opensky-network.org/api/states/all';

  Future<OpenSky?> fetchOpenSkyData() async {
    try {
      final uri =
          Uri.parse('$baseUrl?lamin=6.45&lomin=68.7&lamax=37.6&lomax=97.25');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return OpenSky.fromJson(data);
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
