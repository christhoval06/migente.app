// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      count: json['count'] as int,
      page: json['page'] as int,
      pages: json['pages'] as int,
      perPage: json['per_page'] as int,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'page': instance.page,
      'pages': instance.pages,
      'per_page': instance.perPage,
    };
