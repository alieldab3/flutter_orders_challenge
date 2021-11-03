import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/orders_provider.dart';
import '../widgets/card_item.dart';

class OrdersMetricsScreen extends StatefulWidget {
  const OrdersMetricsScreen({Key? key}) : super(key: key);

  static const routeName = '/orders-metrics';

  @override
  _OrdersMetricsScreenState createState() => _OrdersMetricsScreenState();
}

class _OrdersMetricsScreenState extends State<OrdersMetricsScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final Map<String, num> ordersMetrics = ordersProvider.ordersMetrics;

    return Scaffold(
      appBar: kIsWeb
          ?
          //WEB
          AppBar(
              foregroundColor: Theme.of(context).accentColor,
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
              title: const Text("Orders Metrics"),
            ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 50, 16, 16),
          // padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CardItem(
                  width: kIsWeb ? 400 : 200,
                  height: kIsWeb ? 600 : 300,
                  title: 'Total Count',
                  subTitle: ordersMetrics['totalCount'].toString(),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardItem(
                      width: kIsWeb ? 400 : 200,
                      height: kIsWeb ? 295 : 147.5,
                      title: 'Average Price',
                      subTitle:
                          '\$ ${ordersMetrics['averagePrice']!.toStringAsFixed(2)}',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CardItem(
                      width: kIsWeb ? 400 : 200,
                      height: kIsWeb ? 295 : 147.5,
                      title: 'Orders Returns',
                      subTitle: ordersMetrics['returnsNo'].toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
