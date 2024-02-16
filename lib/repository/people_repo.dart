import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:mi_gente/config/strings.dart';
import 'package:mi_gente/models/people.dart';
import 'package:mi_gente/models/person.dart';

var logger = Logger();

class PeopleRepo {
  Future<People> getPeople({String? ndi}) async {
    Map<String, String> queryParams = {};

    if (ndi != null) {
      queryParams.addEntries({"ndi": ndi}.entries);
    }

    final Uri url = Uri.https(
        baseApiUrl, ResourcePath.peopleSearch.path(peopleId: 0), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    // final body = jsonEncode({'name': 'John Doe', 'email': 'john@example.com'});
    // final response = await http.post(url, headers: headers, body: body);

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
}
