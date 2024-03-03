import 'dart:async';
import 'package:flightsky/constants.dart';
import 'package:flightsky/models/LatLong.dart';
import 'package:flightsky/models/flightsapi.dart';
import 'package:flightsky/models/opensky.dart';
import 'package:flightsky/pages/components/flight_card.dart';
import 'package:flightsky/pages/components/search_bar.dart';
import 'package:flightsky/repository/flightsapi_client.dart';
import 'package:flightsky/repository/opensky_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  OpenSky? data;
  Timer? timer;

  Future<void> fetchOpenSkyData() async {
    coordinates = [];
    markers = [];
    flights = [];
    data = await OpenSkyClient().fetchOpenSkyData();
    setState(() {});
    if (kDebugMode) {
      if (data != null) {
        getCoordinates(data!);
        print(data!.states!);
        // getCoordinates(data!);
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
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      fetchOpenSkyData();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
                    backgroundColor: Color.fromARGB(255, 65, 90, 92),
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.maxFinite,
                        child: Padding(
                            padding: EdgeInsets.all(20), child: FlightCard()),
                      );
                    });
              },
              child: Transform.rotate(
                  angle: data.states?[i][10] == null
                      ? 0.0
                      : data.states![i][10].toDouble(),
                  child: Icon(Icons.flight, color: Colors.white, size: 15.0)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color.fromARGB(195, 255, 255, 255),
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
            : Stack(
                children: [
                  FlutterMap(
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
                  data == null
                      ? Container()
                      : Positioned(
                          left: 10,
                          right: 10,
                          top: 60,
                          child: GlassEffectSearchBar(list: data!.states!)),
                ],
              ),
      ),
    );
  }
}
