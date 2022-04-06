import 'package:app_store/providers/modalHud.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/screens/user/home_page.dart';
import 'package:app_store/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_store/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "SignupScreen";
  String? _email, _password, _name;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
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
                hint: "Enter Your Name",
                icon: Icons.perm_identity,
                onclick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hint: "Enter Your E-mail",
                icon: Icons.email,
                onclick: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: height * .02,
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
                      final modalhud =
                          Provider.of<ModalHud>(context, listen: false);
                      modalhud.changeIsLoading(true);
                      if (_globalKey.currentState!.validate()) {
                        // do somethings
                        _globalKey.currentState!.save();
                        try {
                          final UserCredential = await _auth.signUp(
                              _name, _email?.trim(), _password?.trim());
                          modalhud.changeIsLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                          // } get error when used this (on PlatformException catch(e)) with e.message{
                        } catch (e) {
                          modalhud.changeIsLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                          ));
                        }
                      }
                      modalhud.changeIsLoading(false);
                    },
                    child: const Text('Sign Up'),
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
                    'You Do Have Account ? ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: const Text(
                      'logIn',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
