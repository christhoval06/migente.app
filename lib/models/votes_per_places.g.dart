// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'votes_per_places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotesPerPlaces _$VotesPerPlacesFromJson(Map<String, dynamic> json) =>
    VotesPerPlaces(
      count: json['count'] as int,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$VotesPerPlacesToJson(VotesPerPlaces instance) =>
    <String, dynamic>{
      'count': instance.count,
      'place': instance.place,
    };
