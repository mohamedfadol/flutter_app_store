import 'package:app_store/models/product.dart';
import 'package:app_store/screens/admin/edit_product.dart';
import 'package:app_store/widgets/custom_menu.dart';
import '../../constants.dart';
import 'package:app_store/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatefulWidget {
  static String id = "ManageProducts";
  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              products.add(Product(
                  pId: doc.id,
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pCategory: data[kProductCategory],
                  pDescript: data[kProductDescription],
                  pLocation: data[kProductLocation]));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: GestureDetector(
                  onTapUp: (details) async {
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
                              Navigator.pushNamed(context, EditProduct.id,arguments: products[index]);
                            },
                            child: Text("Edit"),
                          ),
                          MyPopupMenuItem(
                            onclick: (){
                              _store.deleteProduct(products[index].pId);
                              Navigator.pop(context);
                            },
                            child: Text("Delete"),
                          ),
                        ]);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image:
                              AssetImage(products[index].pLocation.toString()),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[index].pName.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("\$ ${products[index].pPrice}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          }
          return Center(child: Text("Loading ..."));
        },
      ),
    );
  }
}

