import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';

import './providers/orders_provider.dart';
import './screens/orders_graph_screen.dart';
import './screens/orders_metrics_screen.dart';

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
            title: 'FlapKap Challenge',
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

  static const routeName = '/home-screen';

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
                  onPressed: () {},
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
              title: const Text("FlapKap Challenge"),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrdersMetricsScreen.routeName);
                  },
                  child: SizedBox(
                    width: 200,
                    height: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 18,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image:
                                      AssetImage('assets/images/metrics.png'),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Container(
                            color: const Color.fromRGBO(255, 255, 255, 0),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Order',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'bold',
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.deepPurple
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                  Text(
                                    'METRICS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple
                                        // color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrdersGraphScreen.routeName);
                  },
                  child: SizedBox(
                    width: 200,
                    height: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 18,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage('assets/images/graph.png'),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Container(
                            color: const Color.fromRGBO(255, 255, 255, 0),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'Order',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'bold',
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.deepPurple
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                Text(
                                  'GRAPH',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'bold',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple
                                      // color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
