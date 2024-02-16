// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      address: json['address'] as String?,
      birthdate: DateTime.parse(json['birthdate'] as String),
      contact: json['contact'] as String?,
      id: json['id'] as int?,
      isVoted: json['is_voted'] as bool,
      lastNames: json['last_names'] as String,
      names: json['names'] as String,
      ndi: json['ndi'] as String,
      votingBoard: json['voting_board'] as String?,
      votingPlace: json['voting_place'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'address': instance.address,
      'birthdate': instance.birthdate.toIso8601String(),
      'contact': instance.contact,
      'id': instance.id,
      'is_voted': instance.isVoted,
      'last_names': instance.lastNames,
      'names': instance.names,
      'ndi': instance.ndi,
      'voting_board': instance.votingBoard,
      'voting_place': instance.votingPlace,
    };
