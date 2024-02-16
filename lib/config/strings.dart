const String vercelApiUrl = 'mi-gente-backend.vercel.app';
const String renderApiUrl = 'mi-gente-backend.onrender.com';

const String baseApiUrl = vercelApiUrl;

const String accessToken = '3254543-564564-5465-564645';

const String apiBase = '/api';

abstract class ResourcePathDescription {
  String path({int? peopleId});
}

enum ResourcePath implements ResourcePathDescription {
  peopleSearch,
  getPeople,
  savePeople,
  updatePeople,
  upgradePeole,
  deletePeople,
  votingPlace,
  votingPlaceStats,
  votingPlaceVotes;

  @override
  String path({int? peopleId}) {
    switch (this) {
      case ResourcePath.peopleSearch:
      case ResourcePath.savePeople:
        return '$apiBase/people';
      case ResourcePath.getPeople:
      case ResourcePath.updatePeople:
      case ResourcePath.upgradePeole:
      case ResourcePath.deletePeople:
        return '$apiBase/people/$peopleId';
      case ResourcePath.votingPlace:
        return '$apiBase/voting_place';
      case ResourcePath.votingPlaceStats:
        return '$apiBase/voting_place/stat';
      case ResourcePath.votingPlaceVotes:
        return '$apiBase/voting_place/votes';
      default:
        return '$apiBase/people';
    }
  }
}
