import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatefulWidget {
  final String title, imageUrl, id;
  UserProductItem(
    this.title,
    this.imageUrl,
    this.id,
  );

  @override
  _UserProductItemState createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    var _isLoading=false;
    final productData = Provider.of<Products>(context);
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routename, arguments: widget.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
     
                              try {
                                await productData.deleteProduct(widget.id);

                              } catch (error) {
                                scaffold.hideCurrentSnackBar();
                                scaffold.showSnackBar(SnackBar(
                                    content: Text(
                                  "Deleting failed!",
                                  textAlign: TextAlign.center,
                                ),
                                 duration: Duration(seconds: 2),
                                
                                )
                                );

                                throw HttpException("deleting Failed!");
                              }
                             
                            },
                            color: Theme.of(context).errorColor,
                          ),
                           
                          
                        
                      
                    
        
              
              
            
          ],
        ),
      ),
    );
  }
}
