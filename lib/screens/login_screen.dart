import 'package:app_store/providers/admin_mode.dart';
import 'package:app_store/screens/admin/admin_home.dart';
import 'package:app_store/screens/user/home_page.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:app_store/screens/signup_screen.dart';
import 'package:app_store/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_store/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/modalHud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey  = GlobalKey<FormState>();

  final adminPassword = '123456789';

  bool keepMeLoggedIn = false;

  String? _email, _password;

  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('images/icons/buy.png'),
                      Positioned(
                          bottom: 0,
                          child: Text(
                            'Buy Now',
                            style:
                                TextStyle(fontFamily: 'Pacifico', fontSize: 17),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                hint: "Enter Your E-mail",
                icon: Icons.email,
                onclick: (value) {
                  _email = value;
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Checkbox(
                        checkColor: KsecondaryColor,
                          activeColor: KmainColor,
                          value: keepMeLoggedIn,
                          onChanged: (value){
                            setState(() {
                              keepMeLoggedIn = value!;
                            });
                          }
                      ),
                    ),
                    Text("Remember Me",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),

              CustomTextField(
                hint: "Enter Your Password",
                icon: Icons.lock,
                onclick: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: height * .04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white,
                        backgroundColor: Colors.black),
                    onPressed: () async {
                      if (keepMeLoggedIn == true) {
                          keepUserLoggedIn();
                      }
                      _validatelogin(context);
                    },
                    child: const Text('LogIn'),
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You Don\'t Have Account ? ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          "I\'m Admin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? KmainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          "I\'m User",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? Colors.white
                                : KmainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validatelogin(BuildContext context) async {
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeIsLoading(true);
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
             await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
            // } get error when used this (on PlatformException catch(e)) with e.message{
          } catch (e) {
            modalhud.changeIsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
            ));
          }
        } else {
          modalhud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("not admin"),
          ));
        }
      } else {
        try {
           await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
          // } get error when used this (on PlatformException catch(e)) with e.message{
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          )
          );
        }
      }
    }
    modalhud.changeIsLoading(false);
  }

  void keepUserLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
