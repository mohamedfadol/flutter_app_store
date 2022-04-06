import 'package:app_store/models/product.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services/store.dart';

class EditProduct extends StatelessWidget {
  static String id = "EditProduct";
  String? _pro_name,_pro_price,_pro_category,_pro_decrp,_pro_loaction;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: Form(
        key: globalKey,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onSaved: (value){
                    _pro_name = value;
                  },
                  cursorColor: KmainColor,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    filled: true,
                    fillColor: KsecondaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onSaved: (value){
                    _pro_price = value;
                  },
                  cursorColor: KmainColor,
                  decoration: InputDecoration(
                    hintText: "Product Price",
                    filled: true,
                    fillColor: KsecondaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onSaved: (value){
                    _pro_category = value;
                  },
                  cursorColor: KmainColor,
                  decoration: InputDecoration(
                    hintText: "Product Description",
                    filled: true,
                    fillColor: KsecondaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onSaved: (value){
                    _pro_decrp = value;
                  },
                  cursorColor: KmainColor,
                  decoration: InputDecoration(
                    hintText: "Product Decription",
                    filled: true,
                    fillColor: KsecondaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onSaved: (value){
                    _pro_loaction = value;
                  },
                  cursorColor: KmainColor,
                  decoration: InputDecoration(
                    hintText: "Product Location",
                    filled: true,
                    fillColor: KsecondaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton.icon(onPressed: (){
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                      _store.editProduct(({
                        kProductName: _pro_name,
                        kProductLocation: _pro_loaction,
                        kProductPrice: _pro_price,
                        kProductDescription: _pro_decrp,
                        kProductCategory: _pro_category
                      }), product.pId);
                  }
                },
                  icon: Icon(Icons.plus_one),
                  label: Text("Edit Product"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
