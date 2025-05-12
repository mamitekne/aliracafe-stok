import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  final int quantity;

  const ChartWidget({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(toY: quantity.toDouble(), color: Colors.orange),
            ],
          ),
        ],
        titlesData: FlTitlesData(show: true),
      ),
    );
  }
}
