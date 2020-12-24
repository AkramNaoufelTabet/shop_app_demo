import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime datetime;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.datetime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> productsCart, double amount) {
    _orders.insert(
        0,
        OrderItem(
            amount: amount,
            id: DateTime.now().toString(),
            products: productsCart,
            datetime: DateTime.now()));

            notifyListeners();
  }
}
