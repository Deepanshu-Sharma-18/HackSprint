// To parse this JSON data, do
//
//     final openSky = openSkyFromJson(jsonString);

import 'dart:convert';

OpenSky openSkyFromJson(String str) => OpenSky.fromJson(json.decode(str));

String openSkyToJson(OpenSky data) => json.encode(data.toJson());

class OpenSky {
  int? time;
  List<List<dynamic>>? states;

  OpenSky({
    this.time,
    this.states,
  });

  factory OpenSky.fromJson(Map<String, dynamic> json) => OpenSky(
        time: json["time"],
        states: json["states"] == null
            ? []
            : List<List<dynamic>>.from(json["states"]!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "states": states == null
            ? []
            : List<dynamic>.from(
                states!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
