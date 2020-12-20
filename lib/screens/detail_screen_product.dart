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
      body: Container(),
    );
  }
}
