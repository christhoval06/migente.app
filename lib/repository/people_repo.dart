import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:mi_gente/config/strings.dart';
import 'package:mi_gente/models/people.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/models/person_votes.dart';
import 'package:mi_gente/models/votes_per_group.dart';
import 'package:mi_gente/models/votes_per_province.dart';

var logger = Logger();

class PeopleRepo {
  Future<People> getPeople({String? ndi, String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (ndi != null) {
      queryParams.addEntries({"ndi": ndi}.entries);
    }

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(
        baseApiUrl, ResourcePath.peopleSearch.path(peopleId: 0), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return People.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load people');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load people');
    }
  }

  Future<Person> savePerson(Person person, {bool isNew = false}) async {
    String path = ResourcePath.savePeople.path(peopleId: 0);
    if (person.id != null) {
      path = ResourcePath.updatePeople.path(peopleId: person.id);
    }
    final Uri url = Uri.https(baseApiUrl, path);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    Map<String, dynamic> data = person.toJson();
    data.removeWhere((key, value) => value == null);

    final body = jsonEncode(data);

    logger.d(body);
    try {
      Function(Uri,
          {Object? body,
          Encoding? encoding,
          Map<String, String>? headers}) fn = http.put;
      if (isNew) {
        fn = http.post;
      }

      final http.Response res = await fn(url, headers: headers, body: body);

      if (res.statusCode == 200) {
        return Person.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to save person');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to save person');
    }
  }

  Future<List<VotesPerProvince>> getVotesPerProvinces(
      {String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(baseApiUrl,
        ResourcePath.votesPerProvinces.path(votes: votes), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return votesPerProvinceFromJson(res.body);
      } else {
        throw Exception('Failed to load votes per provinces');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load votes per provinces');
    }
  }

  Future<List<VotesPerGroup>> getVotesPerAgeGroup(
      {String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(baseApiUrl,
        ResourcePath.votesPerAgeGroup.path(votes: votes), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return votesPerGroupFromJson(res.body);
      } else {
        throw Exception('Failed to load votes per age group');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load votes per age group');
    }
  }

  Future<PersonVotes> getPeopleVotes({String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(
        baseApiUrl, ResourcePath.personVotes.path(votes: votes), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return personVotesFromJson(res.body);
      } else {
        throw Exception('Failed to load votes per age group');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load votes per age group');
    }
  }
}
