import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mi_gente/ui/widgets/chart/chart_point.dart';
import 'package:mi_gente/ui/widgets/chart/chart_view.dart';

class LineChartView extends ChartView {
  final List<Color> gradientColors;

  LineChartView(
      {super.key, required super.points, required this.gradientColors})
      : super();

  List<FlSpot> getSpots() {
    Iterable<ChartPoint> iterable = Iterable.castFrom(points);
    return iterable.mapIndexed<FlSpot>((index, p) {
      return FlSpot(index.toDouble(), p.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: LineChart(LineChartData(
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
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
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  String name = xLabel[value.toInt()];

                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    angle: 2 * 90 + 45,
                    child: Text(name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                  );
                },
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
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              isCurved: true,
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                ),
              ),
            ),
          ],
        )));
  }
}
