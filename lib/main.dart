import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';

import 'providers/products_provider.dart';
import 'screens/detail_screen_product.dart';
import 'screens/product__overview_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context)=> Products(),
        ),
        ChangeNotifierProvider(
        create: (context)=> Cart(),
        ),
        ChangeNotifierProvider(
          create: (context)=>Orders(),
        )
      ],
        
            child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          
          theme: ThemeData(
            
            primaryColor: HexColor("#ff6501"),
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'
            
            

          ),
          //home: ProductOverviewScreen(),
          routes: {

            "/":(context)=>ProductOverviewScreen(),
            DetailScreenProduct.routename:(context)=>DetailScreenProduct(),
            CartScreen.routename :(context)=>CartScreen(),
            OrderScreen.routename:(context)=>OrderScreen(),
            UserProductsScrenn.routename:(context)=>UserProductsScrenn(),
            EditProductScreen.routename:(context)=>EditProductScreen(),
            
                  },
        ),
      
    );
  }
}


