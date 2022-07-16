import 'package:flutter/material.dart';




class CustomTextField extends StatelessWidget {
     CustomTextField({
    required this.onChange,
    this.controller,
    this.hintText = '',
    this.leading,
    this.obscureText = false,
  });

   final Function(String) onChange;
  final TextEditingController? controller;
  String? hintText;
  Widget? leading;
  bool obscureText;

  @override
  Widget build(BuildContext context)  {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          filled: true,
          fillColor: Colors.white,
          icon: leading,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChange,
        obscureText: obscureText,
      ),
    );
  }
}