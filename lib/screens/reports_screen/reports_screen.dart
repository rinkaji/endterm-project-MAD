import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';

import 'package:myapp/model/theme_selection.dart';

class ReportsScreen extends StatefulWidget {
  ReportsScreen({super.key, required this.participant, required this.theme});
  final Participant participant;
  final ThemeSelection theme;

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int dropDownValue = 1;
  double present = 0;
  double late = 0;
  double absent = 0;
  double excused = 0;

  Future<void> presentAtt() async {
    present = ((await DbHelper.fetchAttendance('$dropDownValue', 'Present',
                widget.participant.ptID!, widget.participant.catID))
            .length)
        .toDouble();
    late = ((await DbHelper.fetchAttendance('$dropDownValue', 'Absent',
                widget.participant.ptID!, widget.participant.catID))
            .length)
        .toDouble();
    absent = ((await DbHelper.fetchAttendance('$dropDownValue', 'Late',
                widget.participant.ptID!, widget.participant.catID))
            .length)
        .toDouble();
    excused = ((await DbHelper.fetchAttendance('$dropDownValue', 'Excused',
                widget.participant.ptID!, widget.participant.catID))
            .length)
        .toDouble();
    setState(() {});
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '';
        break;
      case 1:
        text = '';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  void initState() {
    super.initState();
    presentAtt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.theme.color,
          title: Text('Reports'),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              SizedBox(
                height: 10,
              ),
              
              Center(
                child: AspectRatio(
                  aspectRatio: 2.0,
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(

                      ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: bottomTitles)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: bottomTitles)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: bottomTitles)),
                        ),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: present, color: Colors.green)
                          ]),
                          BarChartGroupData(
                            
                            x: 0,
                            barRods: [
                              BarChartRodData(
                                
                                toY: absent, color: Colors.yellow)
                            ],
                          ),
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: late, color: Colors.red)
                          ]),
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: excused, color: Colors.blue)
                          ]),
                        ]),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    minRadius: 8,
                    maxRadius: 8,
                  ),
                  Text(
                    'Present',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    minRadius: 8,
                    maxRadius: 8,
                  ),
                  Text(
                    'Late',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    minRadius: 8,
                    maxRadius: 8,
                  ),
                  Text(
                    'Absent',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    minRadius: 8,
                    maxRadius: 8,
                  ),
                  Text(
                    'Excused',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text('Attendance report for this',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              DropdownButton(
                  value: dropDownValue,
                  items: const [
                    DropdownMenuItem(child: Text('January'), value: 1),
                    DropdownMenuItem(child: Text('February'), value: 2),
                    DropdownMenuItem(child: Text('March'), value: 3),
                    DropdownMenuItem(child: Text('April'), value: 4),
                    DropdownMenuItem(child: Text('May'), value: 5),
                    DropdownMenuItem(child: Text('June'), value: 6),
                    DropdownMenuItem(child: Text('July'), value: 7),
                    DropdownMenuItem(child: Text('August'), value: 8),
                    DropdownMenuItem(child: Text('September'), value: 9),
                    DropdownMenuItem(child: Text('October'), value: 10),
                    DropdownMenuItem(child: Text('November'), value: 11),
                    DropdownMenuItem(child: Text('December'), value: 12),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      dropDownValue = value!;
                      presentAtt();
                    });
                  })
            ],
          ),
        ));
  }
}
