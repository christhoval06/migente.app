import 'package:mi_gente/models/people.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/models/person_votes.dart';
import 'package:mi_gente/models/votes_per_group.dart';
import 'package:mi_gente/models/votes_per_province.dart';
import 'package:mi_gente/repository/people_repo.dart';
import 'package:mi_gente/ui/locator.dart';

class PeopleDomainController {
  PeopleRepo repo = locator.get<PeopleRepo>();

  Future<People> getPeople({String? ndi, String? votes = 'all'}) async {
    return repo.getPeople(ndi: ndi, votes: votes);
  }

  Future<Person> savePerson(Person person, {bool isNew = false}) async {
    return repo.savePerson(person, isNew: isNew);
  }

  Future<List<VotesPerProvince>> getVotesPerProvinces(
      {String? votes = 'all'}) async {
    return repo.getVotesPerProvinces(votes: votes);
  }

  Future<List<VotesPerGroup>> getVotesPerAgeGroup(
      {String? votes = 'all'}) async {
    return repo.getVotesPerAgeGroup(votes: votes);
  }

  Future<PersonVotes> getPeopleVotes({String? votes = 'all'}) async {
    return repo.getPeopleVotes(votes: votes);
  }
}
