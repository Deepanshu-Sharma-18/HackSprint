import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15.0),
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
                    'accessToken':
                        'pk.eyJ1IjoiZGVlcGFuc2h1MTgxMCIsImEiOiJjbHQ4cG05aHIwdDhiMmlxbXAwbnlndmtnIn0.l_mnRepKUMb8zAy_-YNxkA',
                    'id': 'mapbox.mapbox-streets-v8'
                  },
                ),
                MarkerLayer(markers: [
                  Marker(
                      point: LatLng(20, 78),
                      child: Image.asset('assets/airplane.png'))
                ])
              ],
            )));
  }
}
