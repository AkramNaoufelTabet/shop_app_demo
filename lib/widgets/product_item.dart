import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import '../models/product.dart';
import '../providers/cart.dart';
import '../screens/detail_screen_product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);
    final auth=Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailScreenProduct.routename, arguments: product.id);
        },
        child: GridTile( 
          child: Hero( 
            tag: product.id,
                      child: FadeInImage(

            placeholder:AssetImage('assets/images/product-placeholder.png') ,
            image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
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
              builder: (ctx, product, child) => IconButton(
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () async {
                product.toggleProductFavStatus(auth.token,auth.userId);
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
                cartData.addItem(product.id, product.title, product.price);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(label: "Undo", onPressed: (){
                    cartData.removeSingleItem(product.id);
                  }),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
