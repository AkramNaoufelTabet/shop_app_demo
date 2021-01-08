import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';

import 'package:shop_app/screens/user_product_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';

import 'providers/products_provider.dart';
import 'screens/16.1 splash_screen.dart';
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
          create: (context) => Cart(),
        ),

        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousproducts) => Products(
              auth.token,
              auth.userId,
              previousproducts == null ? [] : previousproducts.items),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders(auth.token,
              auth.userId, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
                primaryColor: HexColor("#ff6501"),
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, autoLoginSnapshot) =>
                        autoLoginSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductOverviewScreen.routename: (context) =>
                  ProductOverviewScreen(),
              DetailScreenProduct.routename: (context) => DetailScreenProduct(),
              CartScreen.routename: (context) => CartScreen(),
              OrderScreen.routename: (context) => OrderScreen(),
              UserProductsScrenn.routename: (context) => UserProductsScrenn(),
              EditProductScreen.routename: (context) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
