// To parse this JSON data, do
//
//     final votingPlaces = votingPlacesFromJson(jsonString);

import 'dart:convert';

List<String> votingPlacesFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String votingPlacesToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
