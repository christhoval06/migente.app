const String vercelApiUrl = 'mi-gente-backend.vercel.app';
const String renderApiUrl = 'mi-gente-backend.onrender.com';

const String baseApiUrl = vercelApiUrl;

const String accessToken = '3254543-564564-5465-564645';

const String apiBase = '/api';

abstract class ResourcePathDescription {
  String path({int? peopleId, String? votes = 'all'});
}

enum ResourcePath implements ResourcePathDescription {
  peopleSearch,
  getPeople,
  savePeople,
  updatePeople,
  upgradePeole,
  deletePeople,

  votesPerProvinces,
  votesPerAgeGroup,
  personVotes,

  votingPlace,
  votingPlaceStats,
  votingPlaceVotes;

  @override
  String path({int? peopleId, String? votes = 'all'}) {
    switch (this) {
      case ResourcePath.peopleSearch:
      case ResourcePath.savePeople:
        return '$apiBase/people';
      case ResourcePath.getPeople:
      case ResourcePath.updatePeople:
      case ResourcePath.upgradePeole:
      case ResourcePath.deletePeople:
        return '$apiBase/people/$peopleId';

      case ResourcePath.votesPerProvinces:
        return '$apiBase/people/provinces/votes/$votes/count';
      case ResourcePath.votesPerAgeGroup:
        return '$apiBase/people/age/votes/$votes/count';
      case ResourcePath.personVotes:
        return '$apiBase/people/votes/$votes/count';

      case ResourcePath.votingPlace:
        return '$apiBase/voting_place';
      case ResourcePath.votingPlaceStats:
        return '$apiBase/voting_place/stat';
      case ResourcePath.votingPlaceVotes:
        return '$apiBase/voting_place/$votes/votes';
      default:
        return '$apiBase/people';
    }
  }
}
