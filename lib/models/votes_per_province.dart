// To parse this JSON data, do
//
//     final votesPerProvince = votesPerProvinceFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'votes_per_province.g.dart';

List<VotesPerProvince> votesPerProvinceFromJson(String str) =>
    List<VotesPerProvince>.from(
        json.decode(str).map((x) => VotesPerProvince.fromJson(x)));

String votesPerProvinceToJson(List<VotesPerProvince> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class VotesPerProvince {
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "province")
  String province;

  VotesPerProvince({
    required this.count,
    required this.province,
  });

  factory VotesPerProvince.fromJson(Map<String, dynamic> json) =>
      _$VotesPerProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$VotesPerProvinceToJson(this);
}
