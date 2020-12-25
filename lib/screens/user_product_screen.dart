import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductsScrenn extends StatelessWidget {
  static String routename="/UserProduct";
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount:productData.items.length ,
          itemBuilder: (_,i){
            return Column(
              children: [
                UserProductItem(productData.items[i].title, productData.items[i].imageUrl,productData.items[i].id),
                Divider(),
              ],
            );

          }),
      ),
    );
  }
}
