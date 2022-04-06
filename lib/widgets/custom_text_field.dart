import 'package:flutter/material.dart';

import '../constants.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final void Function(String?) onclick;
  String _errorMessage(String str){
    switch  (hint){
      case "Enter Your Name": return "Username cann\'t be empty";
      case "Enter Your E-mail": return "E-mail cann\'t be empty";
      case "Enter Your Password": return "Password cann\'t be empty";
      default:
        return '';
    }
  }
  CustomTextField({ required this.hint, required this.icon ,required this.onclick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return _errorMessage(hint);
          }
        },
        onSaved: onclick,
        obscureText: hint == "Enter Your Password" ? true : false,
        cursorColor: KmainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon,color: KmainColor,),
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
    );
  }
}
