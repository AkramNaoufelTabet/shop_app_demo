import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id, title,productId;
  final double price;
  final int quantity;
  CartItem({this.id, this.title, this.productId,this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);

      },
      background: Container(color: Theme.of(context).errorColor,
      child: Icon(Icons.delete,size: 30,color: Colors.white,),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right:20),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),

      ),

          child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Padding(
          padding: EdgeInsets.all(6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(4),
                            child: FittedBox(
                    child: Text(
                  '\$$price',
                  style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),
                ),),
              ),
            ),
            title: Text("$title"),
            subtitle: Text("${(quantity * price).toStringAsFixed(2)}"),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
