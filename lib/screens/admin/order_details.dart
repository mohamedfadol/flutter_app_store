import 'package:app_store/constants.dart';
import 'package:app_store/models/product.dart';
import 'package:app_store/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String orderId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrdersDetails(orderId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;
                products.add(Product(
                  pName: data[kProductName],
                  pCategory: data[kProductCategory],
                  pQty: data[kProductQuantity],
                ));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: KsecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Name :  ${products[index].pName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Products Quantity : ${products[index].pQty}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Products Category : ${products[index].pCategory}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KmainColor,
                            child: MaterialButton(onPressed: (){},
                            child: Text("Delete Orders")
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KmainColor,
                            child: MaterialButton(onPressed: (){},
                                child: Text("Confirm Orders")
                            ),
                          ),
                        )

                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text("Loaded OrdersDetalis"),
              );
            }
          }),
    );
  }
}
