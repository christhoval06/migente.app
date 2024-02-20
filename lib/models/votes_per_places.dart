// To parse this JSON data, do
//
//     final votesPerPlaces = votesPerPlacesFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'votes_per_places.g.dart';

List<VotesPerPlaces> votesPerPlacesFromJson(String str) =>
    List<VotesPerPlaces>.from(
        json.decode(str).map((x) => VotesPerPlaces.fromJson(x)));

String votesPerPlacesToJson(List<VotesPerPlaces> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class VotesPerPlaces {
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "place")
  String? place;

  VotesPerPlaces({
    required this.count,
    required this.place,
  });

  factory VotesPerPlaces.fromJson(Map<String, dynamic> json) =>
      _$VotesPerPlacesFromJson(json);

  Map<String, dynamic> toJson() => _$VotesPerPlacesToJson(this);
}
