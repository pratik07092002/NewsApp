import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final Icon prefixicon;
  final bool obscure;
  final TextEditingController? controller;
  final int? maxlines;
  final int? maxkength;
  final Function(String)? onChanged;

  const CustomTextForm({
    super.key, 
    required this.hinttext, 
    required this.prefixicon, 
    required this.obscure, 
    required this.controller, 
    this.maxlines,
    this.maxkength, 
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      maxLines: maxlines ?? 1, 
      maxLength: maxkength,
      onChanged: onChanged, 
      style: TextStyle(color: Colors.red),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade50,
        filled: true,
        prefixIconColor: Colors.red, 
        labelStyle: TextStyle(color: Colors.grey),
        hintText: hinttext, 
        prefixIcon: prefixicon, 
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ), 
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), 
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), 
      ),
    );
  }
}
