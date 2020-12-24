import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class DetailScreenProduct extends StatelessWidget {
  static String routename = "/DetailScreenProduct";
  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context).settings.arguments as String;
    final prod = Provider.of<Products>(context).findById(prodId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${prod.title}"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              prod.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${prod.price}',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,

              child: Text(
                
            prod.description,
            softWrap: true,
            textAlign: TextAlign.center,
          ))
        ],
      )),
    );
  }
}
