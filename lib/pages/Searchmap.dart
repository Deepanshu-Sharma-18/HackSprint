import 'package:flightsky/models/flights.dart';

import 'package:flutter/material.dart';

class SearchFlightPage extends StatefulWidget {
  const SearchFlightPage({Key? key}) : super(key: key);

  @override
  _SearchFlightPageState createState() => _SearchFlightPageState();
}

class _SearchFlightPageState extends State<SearchFlightPage> {
  bool isDark = false;
  TextEditingController _searchController = TextEditingController();
  List<Flight> flights = [
    Flight(
      flightId: "AI101",
      src: "Mumbai",
      des: "Delhi",
      departureTime: "08:00",
      arrivalTime: "10:30",
      srcCoordinates: [19.0760, 72.8777], 
      desCoordinates: [28.7041, 77.1025],
      passengerCapacity: 150,
      bookedPassengers: 100,
    ),
    Flight(
      flightId: "AI202",
      src: "Chennai",
      des: "Kolkata",
      departureTime: "09:30",
      arrivalTime: "12:00",
      srcCoordinates: [13.0827, 80.2707], 
      desCoordinates: [22.5726, 88.3639], 
      passengerCapacity: 180,
      bookedPassengers: 120,
    ),
    Flight(
      flightId: "AI303",
      src: "Bangalore",
      des: "Hyderabad",
      departureTime: "11:15",
      arrivalTime: "13:00",
      srcCoordinates: [12.9716, 77.5946],
      desCoordinates: [17.3850, 78.4867], 
      passengerCapacity: 200,
      bookedPassengers: 150,
    ),
  ];

  List<Flight> filteredFlights = [];

  @override
  void initState() {
    super.initState();
    filteredFlights = flights;
  }

  void filterFlights(String query) {
    setState(() {
      filteredFlights = flights
          .where((flight) => flight.flightId.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Flights'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  filterFlights(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search by Flight ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredFlights.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredFlights[index].flightId),
                      subtitle: Text(
                          'From: ${filteredFlights[index].src} To: ${filteredFlights[index].des}'),
                      onTap: () {
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}