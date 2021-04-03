import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  String hint = "";
  TextEditingController controller;
  TextFieldLogin({this.hint, this.controller});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        controller: controller,
        onSaved: (value) {
          // _userEmail = value;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          fillColor: Colors.white,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.grey[300]),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.grey[300]),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.grey[300]),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.grey[300]),
          ),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          filled: true,
          hintText: this.hint,
        ),
      ),
    );
  }
}
