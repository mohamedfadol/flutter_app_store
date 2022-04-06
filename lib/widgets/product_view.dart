import 'package:app_store/constants.dart';
import 'package:app_store/functions.dart';
import 'package:app_store/models/product.dart';
import 'package:app_store/screens/user/product_info.dart';
import 'package:flutter/material.dart';

Widget ProductsView(String pCategory,List<Product> allproducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allproducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: .8,
    ),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(products[index].pLocation.toString()),
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
                            style:
                            TextStyle(fontWeight: FontWeight.bold)),
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
