// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:crypto_currencies/token_info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:crypto_currencies/token_history_price.dart';

class ChartWidget extends StatefulWidget {
  final TokenInfo tokenInfo;

  const ChartWidget({
    Key? key,
    required this.tokenInfo,
  }) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> spots = wickList.asMap().entries.map((e) {
    return FlSpot(e.key.toDouble(), e.value.high!.toDouble());
  }).toList();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        wickList.clear();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.tokenInfo.name +
              ' (' +
              widget.tokenInfo.symbol.toUpperCase() +
              ')'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              wickList.clear();
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  height: 300,
                  child: Stack(
                    children: [
                      LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: double.parse(spots
                                  .reduce((item1, item2) =>
                                      item1.y > item2.y ? item1 : item2)
                                  .y
                                  .toString()) *
                              1.2,
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(
                            show: false,
                            // getDrawingHorizontalLine: (value) {
                            //   return FlLine(
                            //     color: Color.fromARGB(255, 71, 74, 76),
                            //     strokeWidth: 1,
                            //   );
                            // },
                            // getDrawingVerticalLine: (value) {
                            //   return FlLine(
                            //     color: Color.fromARGB(255, 71, 74, 76),
                            //     strokeWidth: 1,
                            //   );
                            // },
                          ),
                          lineBarsData: [
                            LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                gradient:
                                    LinearGradient(colors: gradientColors),
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: gradientColors
                                          .map((e) => e.withOpacity(0.15))
                                          .toList(),
                                    ))),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                            children: 
                                  [const SizedBox(height: 10,),
                                    Text(widget
                                  .tokenInfo.marketData.currentPrice!.usd
                                  .toString() + '\$',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text(widget.tokenInfo.marketData.priceChange24h!.toStringAsFixed(2) + '\$', style: const TextStyle(fontSize: 15,),),
                                    const SizedBox(width: 6,),
                                    Text(widget.tokenInfo.marketData.priceChangePercentage24h!.toStringAsFixed(2) + '%', style: TextStyle(fontSize: 15, color: widget.tokenInfo.marketData.priceChangePercentage24h! > 0 ? Colors.green : Colors.red),),
                                  ],)
                                ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: HtmlWidget(
                      widget.tokenInfo.description.en,
                      textStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
