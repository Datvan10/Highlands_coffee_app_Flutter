import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class EditTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final Color iconColor;
  final TextEditingController controller;

  const EditTextFormField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.controller, required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(15),
        filled: true,
        fillColor: white,
        prefixIcon: Icon(
          prefixIconData,
          color: iconColor,
        ),
        suffixIcon: suffixIconData != null
            ? IconButton(
                onPressed: () {
                  // Xử lý khi nhấn nút clear
                  controller.clear();
                },
                icon: Icon(
                  suffixIconData,
                  color: iconColor,
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
