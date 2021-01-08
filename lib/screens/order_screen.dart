import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrderScreen extends StatefulWidget {
  static String routename = "/Orders";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


var orders;



  Future<void> fetchData() async {
    try{
      await Provider.of<Orders>(context, listen: false).fetchData();
     setState(() {
       
     });
    }catch(error){
      return null;
    }
     
     
    
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
          onRefresh: fetchData,
          displacement: 2,
          child: FutureBuilder(

              future: Provider.of<Orders>(context, listen: false).fetchData(),
              builder: (ctx, datasnapshot) {
                if (datasnapshot.connectionState == ConnectionState.waiting) {
                  
                  return Center(child: CircularProgressIndicator());
                } else {
                 print(datasnapshot.error);
             

                  
                  if (datasnapshot.error != null ) {
                    
                    return Center(
                      child: Text("No orders to show ."),
                    );
                  } else {
                      
                    
                  
                    return Consumer<Orders>(
                      builder: (ctx, ordersData, child) {
                        return ListView.builder(
                            itemCount: ordersData.orders.length,
                            itemBuilder: (context, index) {
                              return OrderItem(ordersData.orders[index]);
                            });
                      },
                    );
                    }
                  
                }
              })),
    );
  }
}
