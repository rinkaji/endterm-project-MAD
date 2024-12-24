import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:myapp/model/theme_selection.dart';

class ReportsScreen extends StatefulWidget {
  ReportsScreen({super.key, required this.name, required this.theme});
  final String name;
  final ThemeSelection theme;

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<BarChartGroupData> barChartData = [
    BarChartGroupData(
        x: 1, barRods: [BarChartRodData(toY: 3, color: Colors.green)]),
    BarChartGroupData(
        x: 2, barRods: [BarChartRodData(toY: 1, color: Colors.red)]),
    BarChartGroupData(
        x: 3, barRods: [BarChartRodData(toY: 2, color: Colors.orange)]),
    BarChartGroupData(
        x: 4, barRods: [BarChartRodData(toY: 1, color: Colors.blue)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.theme.color,
        title: Text('${widget.name} Reports'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
      body: Column(
        children: [
          Text('Attendance report for this'),
          Center(
        child: AspectRatio(
          aspectRatio: 2.0,
          child: Container(
            margin: EdgeInsets.all(20),
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: 40)
                    ]
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: 1)
                    ],
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: 5)
                    ]
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: 10)
                    ]
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
        ],
      )
    );
  }
}
