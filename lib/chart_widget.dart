// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:crypto_currencies/token_info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:crypto_currencies/token_history_price.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatefulWidget {
  final TokenInfo tokenInfo;

  const ChartWidget({
    super.key,
    required this.tokenInfo,
  });

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  var style = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontSize: 15,
  ));

  bool status = false;

  List<FlSpot> spots = wickList.asMap().entries.map((e) {
    return FlSpot(e.value.time!.toDouble(), e.value.high!.toDouble());
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
          title: Text('${widget.tokenInfo.name} (${widget.tokenInfo.symbol.toUpperCase()})'),
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
                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey[100] : Colors.grey[800],
                  ),
                  height: 300,
                  child: Stack(
                    children: [
                      LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: double.parse(
                                  spots.reduce((item1, item2) => item1.y > item2.y ? item1 : item2).y.toString()) *
                              1.4,
                          lineTouchData: const LineTouchData(
                            enabled: true,
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
                                reservedSize: 20,
                                interval: 86400000 * 102,
                                getTitlesWidget: (value, meta) {
                                  String dateTimeString =
                                      DateFormat('MMM').format(DateTime.fromMillisecondsSinceEpoch(value.toInt()));
                                  return SizedBox(
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(dateTimeString),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(
                            show: false,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                gradient: LinearGradient(colors: gradientColors),
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: gradientColors.map((e) => e.withOpacity(0.15)).toList(),
                                    ))),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(children: [
                          const SizedBox(height: 10),
                          Text(
                            '${widget.tokenInfo.marketData.currentPrice!.usd}\$',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.tokenInfo.marketData.priceChange24h!.toStringAsFixed(2)}\$',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.tokenInfo.marketData.priceChangePercentage24h!.toStringAsFixed(2)}%',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: widget.tokenInfo.marketData.priceChangePercentage24h! > 0
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          )
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
                      color: Theme.of(context).brightness == Brightness.light ? Colors.grey[100] : Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Price Notification',
                              style: style,
                            ),
                            const Spacer(),
                            FlutterSwitch(
                              width: 45.0,
                              height: 25.0,
                              activeColor: const Color.fromARGB(253, 100, 97, 97),
                              toggleSize: 15.0,
                              value: status,
                              switchBorder: Border.all(
                                color: Colors.white,
                                width: 1.2,
                              ),
                              borderRadius: 30.0,
                              padding: 4.0,
                              showOnOff: false,
                              onToggle: (val) {
                                setState(() {
                                  status = val;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        HtmlWidget(
                          widget.tokenInfo.description.en,
                          textStyle: style,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              'Homepage',
                              style: style,
                            ),
                            const Spacer(),
                            Linkify(
                              onOpen: (link) => _launch(),
                              text: widget.tokenInfo.links.homepage.first,
                              linkStyle: style,
                            ),
                          ],
                        )
                      ],
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

  void _launch() async {
    var url = widget.tokenInfo.links.homepage.first;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
