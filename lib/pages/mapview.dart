import 'dart:async';
import 'package:flightsky/constants.dart';
import 'package:flightsky/models/LatLong.dart';
import 'package:flightsky/models/opensky.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  final OpenSky list;
  const MapView({super.key, required this.list});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLong> coordinates = [];
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getCoordinates(widget.list);
  }

  void getCoordinates(OpenSky data) {
    for (var i = 0; i < data.states!.length; i++) {
      coordinates.add(LatLong(
        lat: data.states?[i][6] == null ? -1 : data.states![i][6],
        long: data.states?[i][5] == null ? -1 : data.states![i][5],
      ));
    }

    if (coordinates.isNotEmpty) {
      for (var i = 0; i < coordinates.length; i++) {
        markers.add(Marker(
            point: LatLng(coordinates[i].lat, coordinates[i].long),
            child: Image.asset(
              'assets/airplane.png',
            )));
      }
      if (kDebugMode) {
        print("markers");
        print(markers);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        // child: Container()));
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(20, 78),
            initialZoom: 5,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/deepanshu1810/clt8r9qq9006y01qr13915rfg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGVlcGFuc2h1MTgxMCIsImEiOiJjbHQ4cG05aHIwdDhiMmlxbXAwbnlndmtnIn0.l_mnRepKUMb8zAy_-YNxkA',
              additionalOptions: {
                'accessToken': access_key,
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayer(
              markers: markers,
            ),
          ],
        ),
      ),
    );
  }
}
