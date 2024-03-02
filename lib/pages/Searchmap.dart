import 'package:flutter/material.dart';
import 'package:flightsky/models/flights.dart';

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
    // Define other flights similarly
  ];

  List<Flight> filteredFlights = [];

  @override
  void initState() {
    super.initState();
    filteredFlights = [];
  }

  void filterFlights(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredFlights = flights
            .where((flight) => flight.flightId.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredFlights = [];
      }
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

