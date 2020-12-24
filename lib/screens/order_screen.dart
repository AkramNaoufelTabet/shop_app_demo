import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';
import '../providers/orders.dart' show Orders;
class OrderScreen extends StatelessWidget {
  static String routename="/Orders";
  @override
  Widget build(BuildContext context) {
    final ordersData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"),),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount:ordersData.orders.length ,
        itemBuilder: (context,index){
          return OrderItem(ordersData.orders[index]);
        }),
      
    );
  }
}