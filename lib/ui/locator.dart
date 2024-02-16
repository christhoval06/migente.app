import 'package:get_it/get_it.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/repository/people_repo.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<PeopleDomainController>(
      () => PeopleDomainController());
  locator.registerLazySingleton<PeopleRepo>(() => PeopleRepo());
}
