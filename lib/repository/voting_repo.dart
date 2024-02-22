import 'package:http/http.dart' as http;
import 'package:mi_gente/config/strings.dart';
import 'package:mi_gente/models/votes_per_places.dart';
import 'package:mi_gente/models/voting_places.dart';
import 'package:mi_gente/models/voting_places_stats.dart';
import 'package:mi_gente/utils/logger.dart';

class VotingRepo {
  Future<List<String>> getVotingPlace() async {
    final Uri url = Uri.https(baseApiUrl, ResourcePath.votingPlace.path());

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return votingPlacesFromJson(res.body);
      } else {
        throw Exception('Failed to load voting places');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load voting places');
    }
  }

  Future<List<VotingPlacesStats>> getVotingPlaceStats(
      {String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(baseApiUrl,
        ResourcePath.votingPlaceStats.path(votes: votes), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return votingPlacesStatsFromJson(res.body);
      } else {
        throw Exception('Failed to load votes per age group');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load votes per age group');
    }
  }

  Future<List<VotesPerPlaces>> getVotingPlaceVotes(
      {String? votes = 'all'}) async {
    Map<String, String> queryParams = {};

    if (votes != null) {
      queryParams.addEntries({"votes": votes}.entries);
    }

    final Uri url = Uri.https(baseApiUrl,
        ResourcePath.votingPlaceVotes.path(votes: votes), queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': accessToken,
    };

    try {
      final http.Response res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return votesPerPlacesFromJson(res.body);
      } else {
        throw Exception('Failed to load votes per age group');
      }
    } catch (e) {
      logger.d(e.toString(), error: e);
      throw Exception('Failed to load votes per age group');
    }
  }
}
