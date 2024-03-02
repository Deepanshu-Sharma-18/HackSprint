import 'dart:convert';

List<FlightsApi> flightsApiFromJson(String str) =>
    List<FlightsApi>.from(json.decode(str).map((x) => FlightsApi.fromJson(x)));

String flightsApiToJson(List<FlightsApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FlightsApi {
  List<Arrival>? departure;
  List<Arrival>? arrival;

  FlightsApi({
    this.departure,
    this.arrival,
  });

  factory FlightsApi.fromJson(Map<String, dynamic> json) => FlightsApi(
        departure: json["departure"] == null
            ? []
            : List<Arrival>.from(
                json["departure"]!.map((x) => Arrival.fromJson(x))),
        arrival: json["arrival"] == null
            ? []
            : List<Arrival>.from(
                json["arrival"]!.map((x) => Arrival.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "departure": departure == null
            ? []
            : List<dynamic>.from(departure!.map((x) => x.toJson())),
        "arrival": arrival == null
            ? []
            : List<dynamic>.from(arrival!.map((x) => x.toJson())),
      };
}

class Arrival {
  String? airport;
  String? scheduledTime;
  String? atGateTime;
  String? terminalGate;
  String? takeoffTime;

  Arrival({
    this.airport,
    this.scheduledTime,
    this.atGateTime,
    this.terminalGate,
    this.takeoffTime,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        airport: json["Airport:"],
        scheduledTime: json["Scheduled Time:"],
        atGateTime: json["At Gate Time:"],
        terminalGate: json["Terminal - Gate:"],
        takeoffTime: json["Takeoff Time:"],
      );

  Map<String, dynamic> toJson() => {
        "Airport:": airport,
        "Scheduled Time:": scheduledTime,
        "At Gate Time:": atGateTime,
        "Terminal - Gate:": terminalGate,
        "Takeoff Time:": takeoffTime,
      };
}
