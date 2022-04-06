import 'package:app_store/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class Store{
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   addProduct(Product product){
      _firestore.collection(kProductsCollection).add({
         kProductName: product.pName,
         kProductPrice: product.pPrice,
         kProductCategory: product.pCategory,
         kProductDescription: product.pDescript,
         kProductLocation: product.pLocation
      });
   }

   Stream<QuerySnapshot> loadProducts()  {
         return  _firestore.collection(kProductsCollection).snapshots();
   }

   deleteProduct(documentId){
      _firestore.collection(kProductsCollection).doc(documentId).delete();
   }

   editProduct(data,documentId){
      _firestore.collection(kProductsCollection).doc(documentId).update(data);
   }


   storeOrders(data,List<Product> products){
      var docRef = _firestore.collection(kOrders).doc();
      docRef.set(data);
      for(var product in products){
         docRef.collection(kOrderDetails).doc().set({
            kProductName: product.pName,
            kProductPrice: product.pPrice,
            kProductQuantity: product.pQty,
            kProductLocation: product.pLocation,
            kProductCategory: product.pCategory
         });
      }
   }

   Stream<QuerySnapshot> loadOrders()  {
      return  _firestore.collection(kOrders).snapshots();
   }

   Stream<QuerySnapshot> loadOrdersDetails(orderId)  {
      return  _firestore.collection(kOrders).doc(orderId).collection(kOrderDetails).snapshots();
   }
}