// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'votes_per_province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotesPerProvince _$VotesPerProvinceFromJson(Map<String, dynamic> json) =>
    VotesPerProvince(
      count: json['count'] as int,
      province: json['province'] as String,
    );

Map<String, dynamic> _$VotesPerProvinceToJson(VotesPerProvince instance) =>
    <String, dynamic>{
      'count': instance.count,
      'province': instance.province,
    };
