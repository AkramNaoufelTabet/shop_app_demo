import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum Filtersoption {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static String routename = '/productScreen';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouritesonly = false;
  var _isInit = true;
  var _isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }
Future<void> _refreshProducts() async{
    await Provider.of<Products>(context,listen: false).fetchData();
    
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.cartAmount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routename);
                }),
          ),
          PopupMenuButton(
            onSelected: (Filtersoption seledtedValue) {
              setState(() {
                if (seledtedValue == Filtersoption.Favourites) {
                  _showFavouritesonly = true;
                } else {
                  _showFavouritesonly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favourites"),
                value: Filtersoption.Favourites,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: Filtersoption.All,
              )
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            key: _refreshIndicatorKey,
            displacement: 2,
            onRefresh:_refreshProducts,
            child: ProductsGrid(_showFavouritesonly)),
    );
  }
}
