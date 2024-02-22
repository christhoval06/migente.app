import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mi_gente/ui/widgets/chart/chart_view.dart';

import 'chart_point.dart';

class BarChartView extends ChartView {
  final Color barColor;

  BarChartView({super.key, required super.points, required this.barColor})
      : super();

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            ChartPoint point = points[group.x];
            return BarTooltipItem(
              '${point.label}\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "${(point.value).toString()} votos",
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return getTitles(xLabel, value, meta);
            },
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    ));
  }

  BarChartGroupData makeGroupData(int x, double y,
      {double width = 16, double maxY = 15}) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        color: barColor,
        width: width,
        borderSide: const BorderSide(color: Colors.orangeAccent, width: 0),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: maxY,
          color: Colors.black12,
        ),
      ),
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    Iterable<ChartPoint> iterable = Iterable.castFrom(points);
    Iterable<double> values = iterable.map((p) => p.value);
    double maxY = values.reduce(max).toDouble();
    return values.mapIndexed<BarChartGroupData>((index, value) {
      return makeGroupData(index, value, maxY: maxY);
    }).toList();
  }

  Widget getTitles(List<String> xLabel, double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(xLabel[value.toInt()],
          style: const TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )),
    );
  }
}
