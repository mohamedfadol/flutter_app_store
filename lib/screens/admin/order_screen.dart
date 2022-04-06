import 'package:app_store/constants.dart';
import 'package:app_store/models/Order.dart';
import 'package:app_store/screens/admin/order_details.dart';
import 'package:app_store/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No Orders Founded");
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              orders.add(Order(
                  orderId: doc.id,address: data[kAddress], totalPrice: data[kTotallPrice]));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].orderId);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height *.2,
                    color: KsecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Price : \$ ${orders[index].totalPrice.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(height: 10,),
                          Text("Order Address : ${orders[index].address.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
