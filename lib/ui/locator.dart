import 'package:get_it/get_it.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/domain/voting_controller.dart';
import 'package:mi_gente/repository/people_repo.dart';
import 'package:mi_gente/repository/voting_repo.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<PeopleDomainController>(
      () => PeopleDomainController());
  locator.registerLazySingleton<VotingDomainController>(
      () => VotingDomainController());

  locator.registerLazySingleton<PeopleRepo>(() => PeopleRepo());
  locator.registerLazySingleton<VotingRepo>(() => VotingRepo());
}
