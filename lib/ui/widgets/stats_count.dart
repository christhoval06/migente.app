import 'package:flutter/material.dart';

class StatsCount extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const StatsCount(
      {super.key,
      required this.label,
      required this.value,
      required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 200,
        child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                        color: valueColor,
                        fontSize: 42,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(label,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87)),
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
    ]);
  }
}
