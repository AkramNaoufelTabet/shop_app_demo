import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum Filtersoption{
   Favourites,
   All,
 }
class ProductOverviewScreen extends StatefulWidget {
  static String routename='/';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouritesonly=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(

            onSelected: (Filtersoption seledtedValue){
             setState(() {
                if(seledtedValue==Filtersoption.Favourites){
                _showFavouritesonly=true;
              }else{
                _showFavouritesonly=false;
              }
             });
              
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>
              [
                PopupMenuItem(child: Text("Only Favourites"),value: Filtersoption.Favourites,
                
                
                ),
                PopupMenuItem(child: Text("Show all"),
                value: Filtersoption.All,
                )

              ],
            )
        ],
      ),
      body: ProductsGrid(_showFavouritesonly),
      
    );
  }
}

