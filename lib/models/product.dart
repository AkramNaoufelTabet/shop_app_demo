import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;

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
  void setFavValue(bool newValue){
    isFavourite=newValue;
    notifyListeners();
  }
  void toggleProductFavStatus(String authToken,String userId) async{
    var oldStatus=isFavourite;
    isFavourite=!isFavourite;
    notifyListeners();
    final url =
        "https://shopapp-2bf63-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken";
try{
  final response=  await http.put(url,body: json.encode(
    isFavourite,
  ));
  if(response.statusCode>=400){
    setFavValue(oldStatus);

  }
}catch(error){
  setFavValue(oldStatus);
}


  }
  
}