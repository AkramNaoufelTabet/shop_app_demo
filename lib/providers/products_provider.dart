import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouritesOnly {
    return items.where((product) => product.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String productId, title, desc, imageUrl, double price) {
    var product = _items.firstWhere((product) => product.id == productId);
    product.title = title;
    product.price = price;
    product.description = desc;
    product.imageUrl = imageUrl;
    notifyListeners();
  }

  Future<void> addProduct(Product p) async {
    const url =
        "https://shopapp-2bf63-default-rtdb.firebaseio.com/products";
 try{
final response= await http
        .post(url,
            body: json.encode({
              'title': p.title,
              'price': p.price,
              'description': p.description,
              'imageURL': p.imageUrl,
              'isFavourite': p.isFavourite
            }));
              final newProduct = Product(
        id: json.decode(response.body)["name"],
        description: p.description,
        price: p.price,
        imageUrl: p.imageUrl,
        title: p.title,
      );
      _items.add(newProduct);
      notifyListeners();
 }catch(error){
   print(error);
   throw error;
 }
  
       
    
    

   
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
