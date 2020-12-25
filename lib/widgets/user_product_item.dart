import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title, imageUrl,id;
  UserProductItem(
    
    this.title,
    this.imageUrl,
    this.id,
  );
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routename,arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                productData.deleteProduct(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
