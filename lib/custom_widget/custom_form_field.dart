import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  String hintlText;

  MyValidator validator;
  TextEditingController controller;
  TextInputType keyboardType;

  IconButton? suffix;
  bool isPassword;

  CustomFormField(
      {super.key,
      required this.hintlText,
      required this.validator,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.suffix,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      //textDirection: TextDirection,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15)),
        suffixIcon: suffix,
        //labelText: 'Email',
        hintText: hintlText,
        //suffixIcon: ,
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
