import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OrderItem {
  String? id;
  bool? isActive;
  String? price;
  String? company;
  String? picture;
  String? buyer;
  List<String>? tags;
  String? status;
  String? registered;

  OrderItem(
      {this.id,
      this.isActive,
      this.price,
      this.company,
      this.picture,
      this.buyer,
      this.tags,
      this.status,
      this.registered});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    price = json['price'];
    company = json['company'];
    picture = json['picture'];
    buyer = json['buyer'];
    tags = json['tags'].cast<String>();
    status = json['status'];
    registered = json['registered'];
  }
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  Map<String, int> ordersNoPerMonth = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
    '6': 0,
    '7': 0,
    '8': 0,
    '9': 0,
    '10': 0,
    '11': 0,
    '12': 0
  };
  int maxValue = 0;
  String maxKey = '';

  Map<String, num> ordersMetrics = {
    'totalCount': 0,
    'totalPrice': 0.0,
    'averagePrice': 0.0,
    'returnsNo': 0,
  };

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final List<OrderItem> loadedOrders = [];

      final String response =
          await rootBundle.loadString('assets/json/orders.json');
      final List<dynamic> orders = await json.decode(response);

      orders.forEach((order) {
        loadedOrders.add(OrderItem.fromJson(order));
      });

      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Map<String, int> ordersPerMonth() {
    orders.forEach((order) {
      int orderMonth = DateTime.parse(order.registered!).month;
      if (order.status == 'ORDERED') {
        ordersNoPerMonth['$orderMonth'] = ordersNoPerMonth['$orderMonth']! + 1;
      }
    });
    // notifyListeners();
    return ordersNoPerMonth;
  }

  String get maxMonthOrdersKey {
    ordersNoPerMonth.forEach((k, v) {
      if (v > maxValue) {
        maxValue = v;
        maxKey = k;
      }
    });
    return maxKey;
  }

  Map<String, num> setOrdersMetrics() {
    orders.forEach((order) {
      ordersMetrics['totalCount'] = ordersMetrics['totalCount']! + 1;

      ordersMetrics['totalPrice'] = ordersMetrics['totalPrice']! +
          double.parse(order.price!.replaceFirst('\$', '').replaceAll(',', ''));

      if (order.status == 'RETURNED') {
        ordersMetrics['returnsNo'] = ordersMetrics['returnsNo']! + 1;
      }
    });

    ordersMetrics['averagePrice'] =
        ordersMetrics['totalPrice']!.floor() / ordersMetrics['totalCount']!;

    return ordersMetrics;
  }
}
