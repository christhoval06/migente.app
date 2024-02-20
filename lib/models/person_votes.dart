// To parse this JSON data, do
//
//     final personVotes = personVotesFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'person_votes.g.dart';

PersonVotes personVotesFromJson(String str) =>
    PersonVotes.fromJson(json.decode(str));

String personVotesToJson(PersonVotes data) => json.encode(data.toJson());

@JsonSerializable()
class PersonVotes {
  @JsonKey(name: "No")
  int no = 0;
  @JsonKey(name: "Si")
  int si = 0;

  PersonVotes({
    required this.no,
    required this.si,
  });

  factory PersonVotes.fromJson(Map<String, dynamic> json) =>
      _$PersonVotesFromJson(json);

  Map<String, dynamic> toJson() => _$PersonVotesToJson(this);
}
