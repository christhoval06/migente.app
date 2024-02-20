// To parse this JSON data, do
//
//     final votingPlacesStats = votingPlacesStatsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'voting_places_stats.g.dart';

List<VotingPlacesStats> votingPlacesStatsFromJson(String str) =>
    List<VotingPlacesStats>.from(
        json.decode(str).map((x) => VotingPlacesStats.fromJson(x)));

String votingPlacesStatsToJson(List<VotingPlacesStats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class VotingPlacesStats {
  @JsonKey(name: "no_votes")
  int noVotes;
  @JsonKey(name: "place")
  String? place;
  @JsonKey(name: "votes")
  int votes;

  VotingPlacesStats({
    required this.noVotes,
    required this.place,
    required this.votes,
  });

  factory VotingPlacesStats.fromJson(Map<String, dynamic> json) =>
      _$VotingPlacesStatsFromJson(json);

  Map<String, dynamic> toJson() => _$VotingPlacesStatsToJson(this);
}
