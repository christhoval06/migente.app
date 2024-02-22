import 'package:flutter/material.dart';
import 'package:mi_gente/config/config.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/models/models.dart';
import 'package:mi_gente/ui/locator.dart';
import 'package:mi_gente/ui/widgets/chart/chart.dart';
import 'package:mi_gente/ui/widgets/future_stat_view.dart';
import 'package:mi_gente/utils/strings.dart';

// https://unicode.org/Public/emoji/1.0/emoji-data.txt

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Future<PersonVotes> getPeopleVotes() {
    return locator.get<PeopleDomainController>().getPeopleVotes();
  }

  Future<List<VotesPerGroup>> getVotesPerAgeGroup() {
    return locator.get<PeopleDomainController>().getVotesPerAgeGroup();
  }

  Future<List<VotesPerProvince>> getVotesPerProvinces() {
    return locator.get<PeopleDomainController>().getVotesPerProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Cifras"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  FutureStatView(
                      title: 'Mi Gente',
                      future: getPeopleVotes(),
                      render: (PersonVotes votes) {
                        final total = votes.si + votes.no;
                        final double percentYes = (votes.si / total) * 100;

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
                      render: (PersonVotes votes) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${votes.no}',
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
              FutureStatView(
                  title: 'Por Edades',
                  future: getVotesPerAgeGroup(),
                  width: double.infinity,
                  render: (List<VotesPerGroup> data) {
                    final Iterable<VotesPerGroup> iterable =
                        Iterable.castFrom(data);

                    List<ChartPoint> points = iterable
                        .map<ChartPoint>((vote) => ChartPoint(
                            label: groups[vote.group]!,
                            value: vote.count.toDouble()))
                        .toList();

                    return LineChartView(points: points, gradientColors: const [
                      Colors.deepOrange,
                      Colors.orange,
                    ]);
                  }),
              const SizedBox(height: 16),
              FutureStatView(
                  title: 'Por Edades',
                  future: getVotesPerAgeGroup(),
                  width: double.infinity,
                  render: (List<VotesPerGroup> data) {
                    final Iterable<VotesPerGroup> iterable =
                        Iterable.castFrom(data);

                    List<ChartPoint> points = iterable
                        .map<ChartPoint>((vote) => ChartPoint(
                            label: groups[vote.group]!,
                            value: vote.count.toDouble()))
                        .toList();

                    return BarChartView(
                        barColor: Colors.deepOrange, points: points);
                  }),
              const SizedBox(height: 16),
              FutureStatView(
                  title: 'Por Provincias en cédula',
                  future: getVotesPerProvinces(),
                  width: double.infinity,
                  render: (List<VotesPerProvince> data) {
                    final Iterable<VotesPerProvince> iterable =
                        Iterable.castFrom(data);

                    List<ChartPoint> points = iterable
                        .map<ChartPoint>((vote) => ChartPoint(
                            label: provinces[vote.province]!,
                            value: vote.count.toDouble()))
                        .toList();

                    return LineChartView(points: points, gradientColors: const [
                      Colors.indigo,
                      Colors.indigoAccent,
                    ]);
                  }),
              const SizedBox(height: 16),
              FutureStatView(
                  title: 'Por Provincias en cédula',
                  future: getVotesPerProvinces(),
                  width: double.infinity,
                  render: (List<VotesPerProvince> data) {
                    final Iterable<VotesPerProvince> iterable =
                        Iterable.castFrom(data);

                    List<ChartPoint> points = iterable
                        .map<ChartPoint>((vote) => ChartPoint(
                            label: provinces[vote.province]!,
                            value: vote.count.toDouble()))
                        .toList();

                    return BarChartView(
                        barColor: Colors.indigo.shade500, points: points);
                  }),
            ],
          ),
        ));
  }
}
