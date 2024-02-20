import 'package:flutter/material.dart';

class StatCountPercent extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final String value;
  final String hint;
  const StatCountPercent(
      {super.key,
      required this.title,
      required this.value,
      required this.subtitle,
      required this.subtitleColor,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 200,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            value,
                            style: const TextStyle(
                                fontSize: 42, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            subtitle,
                            style:
                                TextStyle(color: subtitleColor, fontSize: 16),
                          ),
                          Text(hint,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black38)),
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
    ]);
  }
}
