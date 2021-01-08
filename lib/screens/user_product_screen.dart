import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../providers/products_provider.dart';
import 'edit_product_screen.dart';

class UserProductsScrenn extends StatelessWidget {
  static String routename="/UserProduct";

  Future<void> _refreshProducts(BuildContext context) async{
   await Provider.of<Products>(context,listen: false).fetchData(true);
  }
  @override
  Widget build(BuildContext context) {
    //print("building..");
    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routename);
        })],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
              future: _refreshProducts(context),
              builder:(ctx,snapshot)=>
              snapshot.connectionState==ConnectionState.waiting ? Center(child: CircularProgressIndicator(),)
               : RefreshIndicator(
           
          onRefresh:()=>_refreshProducts(context) ,
                child: Consumer<Products>(
                                  builder:(ctx,productData,_)=> Padding(
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
                ),
        ),
      ),
    );
  }
}
