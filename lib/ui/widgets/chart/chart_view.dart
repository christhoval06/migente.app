import 'package:flutter/material.dart';

import 'chart_point.dart';

class ChartView extends StatelessWidget {
  final List<ChartPoint> points;

  final List<String> xLabel;

  ChartView({super.key, required this.points})
      : xLabel = points.map((p) => p.label).toList();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
