import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flightsky/constants.dart';
import 'package:flightsky/models/LatLong.dart';
import 'package:flightsky/models/flightsapi.dart';
import 'package:flightsky/models/opensky.dart';
import 'package:flightsky/repository/flightsapi_client.dart';
import 'package:flightsky/repository/opensky_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  OpenSky? data;

  Future<void> fetchOpenSkyData() async {
    data = await OpenSkyClient().fetchOpenSkyData();
    setState(() {});
    if (kDebugMode) {
      if (data != null) {
        getCoordinates(data!);
        print(data!.states!);
        
      }
    }
  }

  List<LatLong> coordinates = [];
  List<Marker> markers = [];
  List<FlightsApi>? flights = [];

  var refresh = false;

  @override
  void initState() {
    super.initState();
    fetchOpenSkyData();
  }

  void getCoordinates(OpenSky data) {
    for (var i = 0; i < data.states!.length; i++) {
      coordinates.add(LatLong(
        lat: data.states?[i][6] == null ? -1 : data.states![i][6].toDouble(),
        long: data.states?[i][5] == null ? -1 : data.states![i][5].toDouble(),
      ));
    }

    if (coordinates.isNotEmpty) {
      for (var i = 0; i < coordinates.length; i++) {
        markers.add(Marker(
            point: LatLng(coordinates[i].lat, coordinates[i].long),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Photo'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.music_note),
                            title: new Text('Music'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.videocam),
                            title: new Text('Video'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.share),
                            title: new Text('Share'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
                // flights = await FlighApiClient().fetchflightsData(797, 'AXB');
                // if (kDebugMode) {
                //   print(flights);
                // }
              },
              child: Transform.rotate(
                angle: data.states?[i][10] == null
                    ? 0.0
                    : data.states![i][10].toDouble(),
                child: Image.asset(
                  height: 10,
                  width: 10,
                  'assets/airplane24.png',
                  fit: BoxFit.cover,
                ),
              ),
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
      // bottomSheet: BottomSheet(onClosing: onClosing, builder: builder),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white60,
        onPressed: () async {
          setState(() {
            refresh = true;
            markers = [];
            coordinates = [];
          });
          await fetchOpenSkyData();
          setState(() {
            refresh = false;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        // child: Container()));

        child: refresh
            ? const SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
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
                    markers: markers,
                  ),
                ],
              ),
      ),
    );
  }
}
