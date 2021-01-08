import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {

  final String authToken;
  final String userId;
  Products(this.authToken,
  this.userId,
  this._items);

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


  Future<void> updateProduct(String productId, title, desc, imageUrl,
      double price, bool isFavourite) async {
    var product = _items.firstWhere((product) => product.id == productId);
    final url =
        "https://shopapp-2bf63-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken";

    await http.patch(url,
        body: json.encode({
          'title': title,
          'price': price,
          'description': desc,
          'imageURL': imageUrl,
          'isFavourite': isFavourite
        }));
    product.title = title;
    product.price = price;
    product.description = desc;
    product.imageUrl = imageUrl;
    notifyListeners();
  }

  Future<void> fetchData([bool filterByUser=false]) async {
   final filterString= filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shopapp-2bf63-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(url);
      final List<Product> loadProducts = [];
      final extracteddata = json.decode(response.body) as Map<String, dynamic>;
        if( extracteddata==null){
        return ;
    }

     url="https://shopapp-2bf63-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken";
     final favoriteResponse=await http.get(url);
     final favoriteData=json.decode(favoriteResponse.body);
      extracteddata.forEach((productId, productData) {
        loadProducts.add(Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['imageURL'],
            isFavourite: favoriteData==null ? false :favoriteData[productId] ?? false,
            price: productData['price']));
      });

      _items = loadProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product p) async {
    final url =
        "https://shopapp-2bf63-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': p.title,
            'price': p.price,
            'description': p.description,
            'imageURL': p.imageUrl,
            'creatorId':userId
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url =
        "https://shopapp-2bf63-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken";
    final exstractingProductIndex =
        _items.indexWhere((product) => product.id == productId);
    var extractingProduct = _items[exstractingProductIndex];
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(exstractingProductIndex, extractingProduct);
      notifyListeners();
      throw HttpException("Could not delete product!");
    }
  }
}
