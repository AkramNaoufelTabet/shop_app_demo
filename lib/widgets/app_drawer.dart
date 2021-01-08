import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/product__overview_screen.dart';
import '../providers/auth.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [

        AppBar(
          title: Text("Hello Friend !"),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Shop"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.routename);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text("Orders"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(OrderScreen.routename);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Manage products"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(UserProductsScrenn.routename);
          },
        ),
        Divider(),

        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Logout"),
          onTap: (){
            
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/");
            Provider.of<Auth>(context,listen: false).logout();
           // Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
          },
        ),
      ],),
      
    );
  }
}