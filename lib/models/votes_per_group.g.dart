// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'votes_per_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotesPerGroup _$VotesPerGroupFromJson(Map<String, dynamic> json) =>
    VotesPerGroup(
      count: json['count'] as int,
      group: json['group'] as String,
    );

Map<String, dynamic> _$VotesPerGroupToJson(VotesPerGroup instance) =>
    <String, dynamic>{
      'count': instance.count,
      'group': instance.group,
    };
