import 'package:mi_gente/models/votes_per_places.dart';
import 'package:mi_gente/models/voting_places_stats.dart';
import 'package:mi_gente/repository/voting_repo.dart';
import 'package:mi_gente/ui/locator.dart';

class VotingDomainController {
  VotingRepo repo = locator.get<VotingRepo>();

  Future<List<String>> getVotingPlace() async {
    return repo.getVotingPlace();
  }

  Future<List<VotingPlacesStats>> getVotingPlaceStats() async {
    return repo.getVotingPlaceStats();
  }

  Future<List<VotesPerPlaces>> getVotingPlaceVotes(
      {String? votes = 'all'}) async {
    return repo.getVotingPlaceVotes(votes: votes);
  }
}
