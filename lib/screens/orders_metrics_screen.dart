import 'package:flapkap_flutter_challenge/providers/orders_provider.dart';
import 'package:flapkap_flutter_challenge/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: const Text('Orders Numeric Metrics'),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 50, 16, 16),
          // padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CardItem(
                  width: 200,
                  height: 300,
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
                      width: 200,
                      height: 147.5,
                      title: 'Average Price',
                      subTitle: '\$ ${ordersMetrics['averagePrice']!.toStringAsFixed(2)}',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CardItem(
                      width: 200,
                      height: 147.5,
                      title: 'Orders\' Returns',
                      subTitle: ordersMetrics['returnsNo'].toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

        // Container(
        //   child: Column(
        //     children: [
        //       const Text('totalCount'),
        //       Text('${ordersMetrics['totalCount']}'),
        //       const Text('averagePrice'),
        //       Text('${ordersMetrics['averagePrice']}'),
        //       const Text('returnsNo'),
        //       Text('${ordersMetrics['returnsNo']}'),
        //     ],
        //   ),
        // ),
        );
  }
}
