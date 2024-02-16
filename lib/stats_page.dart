import 'package:flutter/material.dart';
import 'package:mi_gente/utils/strings.dart';

// https://unicode.org/Public/emoji/1.0/emoji-data.txt

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Cifras"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('New Wins',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '23043'.humanIt(),
                                          style: const TextStyle(
                                              fontSize: 42,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          '\u{2B06}25%',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16),
                                        ),
                                        const Text('vs previous 30 days',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black38)),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
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
                  const Spacer(),
                  Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Colors.white,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '\u{1F446}25%',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Google Rankings',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87)),
                              ],
                            ),
                          )),
                    ),
                    Positioned(
                        top: 0.5,
                        right: 0.5,
                        child: IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {},
                        ))
                  ])
                ],
              ),
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
