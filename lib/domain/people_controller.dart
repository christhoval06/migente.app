import 'package:mi_gente/models/people.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/repository/people_repo.dart';
import 'package:mi_gente/ui/locator.dart';

class PeopleDomainController {
  Future<People> getPeople({String? ndi}) async {
    return locator.get<PeopleRepo>().getPeople(ndi: ndi);
  }

  Future<Person> savePerson(Person person, {bool isNew = false}) async {
    return locator.get<PeopleRepo>().savePerson(person, isNew: isNew);
  }
}
