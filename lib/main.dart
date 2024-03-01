import 'package:flightsky/models/LatLong.dart';
import 'package:flightsky/models/opensky.dart';
import 'package:flightsky/pages/mapview.dart';
import 'package:flightsky/repository/opensky_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OpenSky? data;

  @override
  void initState() {
    fetchOpenSkyData();
    super.initState();
  }

  void fetchOpenSkyData() async {
    data = await OpenSkyClient().fetchOpenSkyData();
    setState(() {});
    if (kDebugMode) {
      if (data != null) {
        print(data!.states!);
        // getCoordinates(data!);
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: data == null
            ? CircularProgressIndicator()
            : MapView(
                list: data!,
              ));
  }
}
