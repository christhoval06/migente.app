// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_places_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotingPlacesStats _$VotingPlacesStatsFromJson(Map<String, dynamic> json) =>
    VotingPlacesStats(
      noVotes: json['no_votes'] as int,
      place: json['place'] as String?,
      votes: json['votes'] as int,
    );

Map<String, dynamic> _$VotingPlacesStatsToJson(VotingPlacesStats instance) =>
    <String, dynamic>{
      'no_votes': instance.noVotes,
      'place': instance.place,
      'votes': instance.votes,
    };
