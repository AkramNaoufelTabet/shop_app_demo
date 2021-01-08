import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class EditProductScreen extends StatefulWidget {
  static String routename = "/Edit";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Product product;
  Products productData;
  var isLoading = false;
  var _title, _price, _desciption, _imageUrl;
  var isInit = true;
  String productId;
  var initValues = {
    'title': "",
    'description': "",
    'price': "",
    "imageURL": ''
  };

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImage);
    super.initState();
  }

  void _updateImage() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (productId != null) {
      await productData
          .updateProduct(product.id, _title, _desciption, _imageUrl, _price,
              product.isFavourite);
    } else {
      try {
        var product = Product(
            id: "",
            title: _title,
            price: _price,
            description: _desciption,
            imageUrl: _imageUrl);
        await productData.addProduct(product);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("An error occured!"),
                content: Text("Something went wrong"),
                actions: [
                  FlatButton(
                    child: Text("Okay"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } 
       
    }
    setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImage);
    _imageURLFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      productId = ModalRoute.of(context).settings.arguments as String;
      productData = Provider.of<Products>(context, listen: false);
      if (productId != null) {
        product = productData.findById(productId);
        initValues = {
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
          'imageURL': "",
        };
        _imageURLController.text = product.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: TextEditingController()
                        ..text = initValues['title'],
                      decoration: InputDecoration(
                          labelText: 'Title', prefixIcon: Icon(Icons.title)),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _title = value;
                      },
                      validator: (title) {
                        if (title.isEmpty) {
                          return "Please enter a title.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: TextEditingController()
                        ..text = initValues['price'],
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.money),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _price = double.parse(value);
                      },
                      validator: (price) {
                        if (price.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(price) == null ||
                            double.parse(price) <= 0) {
                          return 'Please enter a valid price.';
                        }
                      },
                    ),
                    TextFormField(
                      controller: TextEditingController()
                        ..text = initValues['description'],
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description),
                      ),
                      onSaved: (value) {
                        _desciption = value;
                      },
                      validator: (description) {
                        if (description.isEmpty) {
                          return 'Please enter a valid description.';
                        }
                        if (description.length < 10) {
                          return 'Should be at least 10 characters.';
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: _imageURLController.text.isEmpty
                                  ? Center(
                                      child: Text(
                                        'Enter an Image URL',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )
                                  : FittedBox(
                                      child: Image.network(
                                          _imageURLController.text),
                                      fit: BoxFit.cover,
                                    )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) {
                                _imageUrl = value;
                              },
                              controller: _imageURLController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.image),
                                labelText: 'Image URL',
                              ),
                              textInputAction: TextInputAction.done,
                              focusNode: _imageURLFocusNode,
                              keyboardType: TextInputType.url,
                              validator: (imageUrl) {
                                if (imageUrl.isEmpty) {
                                  return 'Please enter a valid URL.';
                                }
                                if (!imageUrl.startsWith('http') &&
                                    !imageUrl.startsWith('https')) {
                                  return 'Please enter a valid Image URL';
                                }
                                if (!imageUrl.endsWith('.png') &&
                                    !imageUrl.endsWith('.jpg') &&
                                    !imageUrl.endsWith('.jpeg')) {
                                  return "Please enter a valid Image URL.";
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    FlatButton(
                      textColor: Colors.white,
                      child: Text('Save'),
                      color: Theme.of(context).primaryColor,
                      onPressed: _saveForm,
                    )
                  ],
                ),
              )),
    );
  }
}
