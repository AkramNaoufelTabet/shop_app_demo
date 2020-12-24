import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/order_screen.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static String routename = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart "),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cartData.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'Order now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).addOrders(
                          cartData.items.values.toList(), cartData.totalAmount);
                          cartData.clear();
                     //     Navigator.of(context).pushNamed(OrderScreen.routename);
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cartData.items.length,
                  itemBuilder: (ctx, index) {
                    return CartItem(
                        id: cartData.items.values.toList()[index].id,
                        productId: cartData.items.keys.toList()[index],
                        title: cartData.items.values.toList()[index].title,
                        price: cartData.items.values.toList()[index].price,
                        quantity:
                            cartData.items.values.toList()[index].quantity);
                  })),
        ],
      ),
    );
  }
}
