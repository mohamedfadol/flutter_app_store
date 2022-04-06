import 'package:app_store/constants.dart';
import 'package:app_store/models/product.dart';
import 'package:app_store/providers/cart_item.dart';
import 'package:app_store/screens/user/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _qty = 1;
  @override
  Widget build(BuildContext context) {
    Product  product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: Stack(
        children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.pLocation!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                      onTap: () {
                            Navigator.pop(context);
                            },
                          child: Icon( Icons.arrow_back_ios),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          },
                          child: Icon(Icons.shopping_cart)
                      ),
                    ],
                  ),
                ),
              ),
          ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Opacity(
                    opacity: .5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height* .3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.pName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height: 5,),
                            Text(product.pDescript!,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                            SizedBox(height: 5,),
                            Text("\$ ${product.pPrice}",style: TextStyle(color: KmainColor,fontWeight: FontWeight.bold,fontSize: 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: KmainColor,
                                    child: GestureDetector(
                                      onTap: add,
                                        child: SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Icon(Icons.add),
                                        ),
                                    ),
                                  ),
                                ),
                                Text(_qty.toString(),style: TextStyle(fontSize: 30),),
                                ClipOval(
                                  child: Material(
                                    color: KmainColor,
                                    child: GestureDetector(
                                      onTap: subtracting,
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  ,
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * .09,
                    child: Builder(
                      builder: (context) {
                        return RaisedButton(onPressed: (){
                          addToCart(context,product);
                        },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)
                            ),
                          ),
                          color: KmainColor,
                          child: Text("Add To Cart".toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }


  add() {
    setState(() {
      _qty ++;
    });
  }

  subtracting() {
    if (_qty > 1) {
      setState(() {
        _qty --;
      });
    }
  }

  void addToCart(context,product) {
    CartItem cartItem = Provider.of<CartItem>(context,listen: false);
    product.pQty = _qty;
    bool exist = false;
    var productsInCart = cartItem.products;
    for(var productInCart in productsInCart){
      if (productInCart.pName == product.pName) {
        exist = true;
      }  
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Existed"),));
    }else{
      cartItem.addProductToCart(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("add Done To Cart"),));
    }

  }
}
