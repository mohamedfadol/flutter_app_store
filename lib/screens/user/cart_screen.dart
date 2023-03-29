import 'package:app_store/constants.dart';
import 'package:app_store/models/product.dart';
import 'package:app_store/providers/cart_item.dart';
import 'package:app_store/screens/admin/manage_product.dart';
import 'package:app_store/screens/user/product_info.dart';
import 'package:app_store/services/store.dart';
import 'package:app_store/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double heightScreen = MediaQuery.of(context).size.height ;
    final double widthScreen = MediaQuery.of(context).size.width ;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("My Cart",style: TextStyle(color: Colors.black),),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints ) {
              if (products.isNotEmpty) {
                return Container(
                  height: heightScreen - statusBarHeight -appBarHeight -(heightScreen * .09),
                  child: ListView.builder(
                    itemBuilder: (context,index)  {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details){
                            showCustomMenu(details,context,products[index]);
                          },
                          child: Container(
                            height: heightScreen * .15,
                            color: KsecondaryColor,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: heightScreen * .15 / 2,
                                  backgroundImage: AssetImage(products[index].pLocation!),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(products[index].pName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 10,),
                                            Text('\$ ${products[index].pPrice!}',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(products[index].pQty.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              }  else{
                return Container(
                  height: heightScreen - (heightScreen * .09) - appBarHeight - statusBarHeight,
                  child: Center(
                      child: Text("Cart Empty"),
                  ),
                );
              }
            }
          ),
          Builder(
            builder: (context) {
              return ButtonTheme(
                minWidth: widthScreen,
                height: heightScreen * .09,
                child: MaterialButton(
                  color: KmainColor,
                    onPressed: (){
                        showCustomDialog(products,context);
                    },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)
                    ),
                  ),
                  child : Text("Order".toUpperCase()
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details,context,product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
    items: [
      MyPopupMenuItem(
        onclick: (){
          Navigator.pop(context);
          Provider.of<CartItem>(context,listen: false).deleteProductFromCart(product);
          Navigator.pushNamed(context, ProductInfo.id,arguments: product);
        },
      child: Text("Edit"),
      ),
      MyPopupMenuItem(
        onclick: (){
          Navigator.pop(context);
          Provider.of<CartItem>(context,listen: false).deleteProductFromCart(product);
        },
      child: Text("Delete"),
      ),
    ]);
  }

  void showCustomDialog(List<Product> products,context) async {
    var _address;
    var price = getTotalPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
            onPressed: ()
            {
              try{
                Store _store = Store();
                _store.storeOrders({
                  kTotallPrice: price,
                  kAddress: _address
                }, products);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                  content: Text("Orderd Successfully"),
                ));
                Navigator.pop(context);
              }catch(e){
                print(e);
              }
            },
          child: Text("Confirm"),
        ),
      ],
      content: TextField(
        onChanged: (value){
          _address = value;
        },
        decoration: InputDecoration(
          hintText: "Enter Your Address",
        ),
      ),
      title: Text("Total Price = \$ ${price}"),
    );
   await showDialog<void>(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for(var product in products){
      price += product.pQty * int.parse(product.pPrice!);
    }
    return price;
  }
}
