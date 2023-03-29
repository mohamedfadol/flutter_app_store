import 'package:app_store/constants.dart';
import 'package:app_store/screens/admin/add_product.dart';
import 'package:app_store/screens/admin/manage_product.dart';
import 'package:app_store/screens/admin/order_screen.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id ='AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      backgroundColor: KmainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          MaterialButton(onPressed: (){
            Navigator.pushNamed(context, AddProduct.id);
          },
          child: Text("add Products"),
          ),

          MaterialButton(onPressed: (){
            Navigator.pushNamed(context, ManageProducts.id);
          },
            child: Text("Products List"),
          ),

          MaterialButton(onPressed: (){
            Navigator.pushNamed(context, OrderScreen.id);
          },
            child: Text("Orders List"),
          ),
        ],
      ),
    );
  }
}
