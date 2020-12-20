import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

import 'product_item.dart';
class ProductsGrid extends StatelessWidget {
final bool showFavouritesOnly;
ProductsGrid(
  this.showFavouritesOnly,
);

  @override
  Widget build(BuildContext context) {
   final productsData=Provider.of<Products>(context);
   final loadedProducts=
   showFavouritesOnly ? productsData.favouritesOnly :
   productsData.items;
    return GridView.builder(
      
      padding: const EdgeInsets.all(10),
       itemCount:loadedProducts.length ,
       gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 1.1,
         crossAxisSpacing: 10,
         mainAxisSpacing: 10,

       ) ,
       itemBuilder: (ctx,index){
         return ChangeNotifierProvider.value(
           value:loadedProducts[index],
                    child: ProductItem(
           
           ),
         );
       });
  }
}