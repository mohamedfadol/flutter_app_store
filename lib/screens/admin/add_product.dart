import 'package:app_store/models/product.dart';
import 'package:app_store/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_store/services/store.dart';

import '../../constants.dart';
class AddProduct extends StatelessWidget {
  static String id ='AddProduct';
  String? _pro_name,_pro_price,_pro_category,_pro_decrp,_pro_loaction;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
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
                      _store.addProduct(Product(
                          pName: _pro_name,
                          pPrice: _pro_price,
                          pCategory: _pro_category,
                          pDescript: _pro_decrp,
                          pLocation: _pro_loaction
                      ));
                    }
                  },
                    icon: Icon(Icons.plus_one),
                    label: Text("add Product"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
