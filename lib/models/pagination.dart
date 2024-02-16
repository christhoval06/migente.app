import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "page")
  int page;
  @JsonKey(name: "pages")
  int pages;
  @JsonKey(name: "per_page")
  int perPage;

  Pagination({
    required this.count,
    required this.page,
    required this.pages,
    required this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
