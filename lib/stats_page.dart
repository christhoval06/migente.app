import 'package:flutter/material.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/models/person_votes.dart';
import 'package:mi_gente/ui/locator.dart';
import 'package:mi_gente/ui/widgets/future_stat_view.dart';
import 'package:mi_gente/ui/widgets/stats_count.dart';
import 'package:mi_gente/utils/strings.dart';

// https://unicode.org/Public/emoji/1.0/emoji-data.txt

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Future<PersonVotes> getPeopleVotes() {
    return locator.get<PeopleDomainController>().getPeopleVotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Cifras"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  FutureStatView(
                      title: 'Mi Gente',
                      future: getPeopleVotes(),
                      render: (PersonVotes? votes) {
                        final total = (votes?.si ?? 0) + (votes?.no ?? 0);
                        final double percentYes =
                            ((votes?.si ?? 0) / total) * 100;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$total'.humanIt(decimals: 0),
                              style: const TextStyle(
                                  fontSize: 42, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${percentYes.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            const Text('ha votado',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black38)),
                          ],
                        );
                      }),
                  const Spacer(),
                  FutureStatView(
                      future: getPeopleVotes(),
                      icon: Icons.navigate_next,
                      onPress: (BuildContext context) {
                        Navigator.pushNamed(context, RoutePaths.list,
                            arguments: {'votes': 'no'});
                      },
                      render: (PersonVotes? votes) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${votes?.no ?? 0}',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text('No han votado!',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87)),
                          ],
                        );
                      }),
                ],
              ),
              const SizedBox(height: 16),
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.amberAccent,
                    child: Column(),
                  ),
                ),
                Positioned(
                    top: 0.5,
                    right: 0.5,
                    child: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {},
                    ))
              ]),
            ],
          ),
        ));
  }
}
