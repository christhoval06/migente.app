// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) => People(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      persons: (json['results'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'pagination': instance.pagination,
      'results': instance.persons,
    };
