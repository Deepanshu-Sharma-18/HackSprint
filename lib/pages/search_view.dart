import 'dart:io';

import 'package:flightsky/constants.dart';
import 'package:flightsky/models/LatLong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SearchView extends StatefulWidget {
  final String searchQuery;
  List<dynamic> list;
  SearchView({super.key, required this.searchQuery, required this.list});

  @override
  State<SearchView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchView> {
  Marker? marker;
  LatLong? coordinates;

  @override
  void initState() {
    super.initState();
    coordinates = null;
    getSearchCoordinates(widget.searchQuery, widget.list);
  }

  void getSearchCoordinates(String searchQuery, List<dynamic> list) {
    for (var i = 0; i < list.length; i++) {
      if (list[i][1] != null && list[i][1].toString().trim() == searchQuery) {
        coordinates = LatLong(
          lat: list[i][6] == null ? -1 : list[i][6].toDouble(),
          long: list[i][5] == null ? -1 : list[i][5].toDouble(),
        );

        print(coordinates!.lat);
        print(coordinates!.long);

        marker = Marker(
          point: LatLng(coordinates!.lat, coordinates!.long),
          child: Transform.rotate(
            angle: list[i][10] == null ? 0.0 : list[i][10].toDouble(),
            child: Image.asset(
              height: 10,
              width: 10,
              'assets/airplane24.png',
              fit: BoxFit.cover,
            ),
          ),
        );

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: coordinates == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(20, 78),
                  initialZoom: 5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/deepanshu1810/clt9kgyby007x01qr09nuc18h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGVlcGFuc2h1MTgxMCIsImEiOiJjbHQ4cG05aHIwdDhiMmlxbXAwbnlndmtnIn0.l_mnRepKUMb8zAy_-YNxkA',
                    additionalOptions: {
                      'accessToken': access_key,
                      'id': 'mapbox.mapbox-streets-v8'
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      marker!,
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
