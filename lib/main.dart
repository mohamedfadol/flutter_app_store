import 'package:app_store/constants.dart';
import 'package:app_store/providers/admin_mode.dart';
import 'package:app_store/providers/cart_item.dart';
import 'package:app_store/providers/modalHud.dart';
import 'package:app_store/screens/admin/add_product.dart';
import 'package:app_store/screens/admin/admin_home.dart';
import 'package:app_store/screens/admin/edit_product.dart';
import 'package:app_store/screens/admin/manage_product.dart';
import 'package:app_store/screens/admin/order_screen.dart';
import 'package:app_store/screens/admin/order_details.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/screens/signup_screen.dart';
import 'package:app_store/screens/user/cart_screen.dart';
import 'package:app_store/screens/user/home_page.dart';
import 'package:app_store/screens/user/product_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_store/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("loading ...."),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
                ChangeNotifierProvider<ModalHud>(
                  create: (context) => ModalHud(),
                ),
                ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignupScreen.id: (context) => SignupScreen(),
                  HomePage.id: (context) => HomePage(),
                  AdminHome.id: (context) => AdminHome(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProducts.id: (context) => ManageProducts(),
                  EditProduct.id: (context) => EditProduct(),
                  ProductInfo.id: (context) => ProductInfo(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderScreen.id: (context) => OrderScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        });
  }
}
