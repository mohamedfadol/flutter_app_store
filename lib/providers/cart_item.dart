import 'package:app_store/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{
  List<Product> products = [];

  addProductToCart(Product product){
    products.add(product);
    notifyListeners();
  }

  deleteProductFromCart(Product product){
    products.remove(product);
    notifyListeners();
  }


}