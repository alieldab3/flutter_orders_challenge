import 'package:flapkap_flutter_challenge/providers/orders_provider.dart';
import 'package:flapkap_flutter_challenge/screens/orders_graph_screen.dart';
import 'package:flapkap_flutter_challenge/screens/orders_metrics_screen.dart';
import 'package:flapkap_flutter_challenge/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: OrdersProvider(),
          ),
        ],
        child: MaterialApp(
            title: 'FlapKap Flutter Challenge',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: const MyHomePage(),
            routes: {
              OrdersMetricsScreen.routeName: (ctx) =>
                  const OrdersMetricsScreen(),
              OrdersGraphScreen.routeName: (ctx) => const OrdersGraphScreen(),
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndSetOrders()
        .then((value) {
      Provider.of<OrdersProvider>(context, listen: false).setOrdersMetrics();
      Provider.of<OrdersProvider>(context, listen: false).ordersPerMonth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlapKap Flutter Challenge"),
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
                child: GestureDetector(
                  child: const CardItem(
                    width: 200,
                    height: 300,
                    title: 'Orders',
                    subTitle: 'Metrics',
                    // child: Text('ss'),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrdersMetricsScreen.routeName);
                  },
                )),
            const SizedBox(
              width: 5,
            ),
            Flexible(
                flex: 1,
                child: GestureDetector(
                  child: const CardItem(
                    width: 200,
                    height: 300,
                    title: 'Orders',
                    subTitle: 'Graph',
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrdersGraphScreen.routeName);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
