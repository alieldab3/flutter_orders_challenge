import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/orders_provider.dart';

class OrdersGraphScreen extends StatefulWidget {
  const OrdersGraphScreen({Key? key}) : super(key: key);

  static const routeName = '/orders-graph';

  @override
  _OrdersGraphScreenState createState() => _OrdersGraphScreenState();
}

class _OrdersGraphScreenState extends State<OrdersGraphScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartData mainData(
      Map<String, int> ordersNoPerMonth, String maxMonthOrdersKey) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Jan';
              case 2:
                return 'Feb';
              case 3:
                return 'Mar';
              case 4:
                return 'Apr';
              case 5:
                return 'May';
              case 6:
                return 'Jun';
              case 7:
                return 'Jul';
              case 8:
                return 'Aug';
              case 9:
                return 'Sep';
              case 10:
                return 'Oct';
              case 11:
                return 'Nov';
              case 12:
                return 'Dec';
            }
            return '';
          },
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 12,
      minY: 0,
      maxY: (ordersNoPerMonth[maxMonthOrdersKey] ?? 0).toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, ordersNoPerMonth['1']!.toDouble()),
            FlSpot(2, ordersNoPerMonth['2']!.toDouble()),
            FlSpot(3, ordersNoPerMonth['3']!.toDouble()),
            FlSpot(4, ordersNoPerMonth['4']!.toDouble()),
            FlSpot(5, ordersNoPerMonth['5']!.toDouble()),
            FlSpot(6, ordersNoPerMonth['6']!.toDouble()),
            FlSpot(7, ordersNoPerMonth['7']!.toDouble()),
            FlSpot(8, ordersNoPerMonth['8']!.toDouble()),
            FlSpot(9, ordersNoPerMonth['9']!.toDouble()),
            FlSpot(10, ordersNoPerMonth['10']!.toDouble()),
            FlSpot(11, ordersNoPerMonth['11']!.toDouble()),
            FlSpot(12, ordersNoPerMonth['12']!.toDouble()),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final Map<String, int> ordersNoPerMonth = ordersProvider.ordersNoPerMonth;
    final String maxMonthOrdersKey = ordersProvider.maxMonthOrdersKey;

    return Scaffold(
      appBar: kIsWeb
          ?
          //WEB
          AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              leading: const SizedBox(
                width: 0,
              ),
              title: Image.asset(
                'assets/images/Shopping_Live_Logo.png',
                fit: BoxFit.cover,
                height: 40,
              ),
              actions: [
                TextButton(
                  child: const Text('Home'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('About'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('Contact'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('Login'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('SIGN UP'),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            )
          :
          //NOT WEB
          AppBar(
              title: const Text("Orders Graph"),
            ),
      body: kIsWeb
          ?
          // WEB
          SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'Number of Orders per Month',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: 700,
                      height: 500,
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff232d37),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 18.0, left: 18.0, top: 24, bottom: 24),
                              child: LineChart(
                                mainData(ordersNoPerMonth, maxMonthOrdersKey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          :
          // NOT WEB
          SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Number of Orders per Month',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff232d37),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 18.0, left: 18.0, top: 24, bottom: 24),
                              child: LineChart(
                                mainData(ordersNoPerMonth, maxMonthOrdersKey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
