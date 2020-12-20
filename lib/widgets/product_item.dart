import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import '../screens/detail_screen_product.dart';

class ProductItem extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailScreenProduct.routename, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            subtitle: Text(
              "\$${product.price}",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (ctx,product,child)=> IconButton(
                

                icon: Icon(
                  product.isFavourite ? 
                  Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                  
                ),
                onPressed: () {
                    product.toggleProductFavStatus();
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                
              },
            ),
          ),
        ),
      ),
    );
  }
}
