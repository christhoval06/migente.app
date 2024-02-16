import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mi_gente/utils/strings.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "birthdate")
  DateTime birthdate;
  @JsonKey(name: "contact")
  String? contact;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_voted")
  bool isVoted;
  @JsonKey(name: "last_names")
  String lastNames;
  @JsonKey(name: "names")
  String names;
  @JsonKey(name: "ndi")
  String ndi;
  @JsonKey(name: "voting_board")
  String? votingBoard;
  @JsonKey(name: "voting_place")
  String? votingPlace;

  Person({
    required this.address,
    required this.birthdate,
    required this.contact,
    required this.id,
    required this.isVoted,
    required this.lastNames,
    required this.names,
    required this.ndi,
    required this.votingBoard,
    required this.votingPlace,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> values = toJson();
    values['birthdate'] = DateTime.parse(values['birthdate']);
    return values;
  }

  String get initials {
    String names = this.names.trim();
    String lastNames = this.lastNames.trim();
    return '$names $lastNames'.getInitials();
  }

  String get dateFormatted {
    return DateFormat('yyyy-MM-dd').format(birthdate);
  }

  static Map<String, dynamic>? ndi2Map(String? result) {
    List<String>? ndiData = result?.decompileNdi();
    if (ndiData == null) {
      return null;
    }

    String birthdate = ndiData.elementAt(6).split('-').reversed.join('-');
    final Map<String, dynamic> values = {
      "is_voted": false,
      "names": ndiData.elementAt(1),
      'last_names': ndiData.elementAt(2),
      'ndi': ndiData.first,
      'birthdate': DateTime.parse(birthdate)
    };

    return values;
  }
}
