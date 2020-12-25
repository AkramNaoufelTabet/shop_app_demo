import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
   String id,title,description,imageUrl;
   double price;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavourite=false,
  });

  void toggleProductFavStatus(){
    isFavourite=!isFavourite;
    notifyListeners();
  }
  
}