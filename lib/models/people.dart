import 'package:json_annotation/json_annotation.dart';
import 'package:mi_gente/models/pagination.dart';
import 'dart:convert';

import 'package:mi_gente/models/person.dart';

// To parse this JSON data, do
//
//     final people = peopleFromJson(jsonString);

part 'people.g.dart';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

String peopleToJson(People data) => json.encode(data.toJson());

@JsonSerializable()
class People {
  @JsonKey(name: "pagination")
  Pagination pagination;
  @JsonKey(name: "results")
  List<Person> persons;

  People({
    required this.pagination,
    required this.persons,
  });

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}

// https://developer.school/tutorials/flutter-using-json_serializable-to-serialise-dart-classes