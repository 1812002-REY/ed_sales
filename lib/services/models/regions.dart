// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Region> welcomeFromJson(String str) =>
    List<Region>.from(json.decode(str).map((x) => Region.fromJson(x)));

String welcomeToJson(List<Region> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Region {
  int id;
  String discription;
  dynamic extendedIndo;

  Region({
    required this.id,
    required this.discription,
    required this.extendedIndo,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    discription: json["discription"],
    extendedIndo: json["extendedIndo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "discription": discription,
    "extendedIndo": extendedIndo,
  };
}
