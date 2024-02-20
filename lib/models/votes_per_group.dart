// To parse this JSON data, do
//
//     final votesPerGroup = votesPerGroupFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'votes_per_group.g.dart';

List<VotesPerGroup> votesPerGroupFromJson(String str) =>
    List<VotesPerGroup>.from(
        json.decode(str).map((x) => VotesPerGroup.fromJson(x)));

String votesPerGroupToJson(List<VotesPerGroup> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class VotesPerGroup {
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "group")
  String group;

  VotesPerGroup({
    required this.count,
    required this.group,
  });

  factory VotesPerGroup.fromJson(Map<String, dynamic> json) =>
      _$VotesPerGroupFromJson(json);

  Map<String, dynamic> toJson() => _$VotesPerGroupToJson(this);
}
