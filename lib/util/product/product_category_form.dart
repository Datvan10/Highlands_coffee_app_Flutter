import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ProductCategoryForm extends StatefulWidget {
  final String titleProduct;
  final Widget destinationPage;

  const ProductCategoryForm({super.key, required this.titleProduct, required this.destinationPage});

  @override
  State<ProductCategoryForm> createState() => _ProductCategoryFormState();
}

class _ProductCategoryFormState extends State<ProductCategoryForm> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isPressed = !isPressed;
        });
        Get.to(widget.destinationPage);
      },
      child: Container(
        height: 25,
        width: 70,
        decoration: BoxDecoration(
          color: isPressed ? primaryColors : white,
          borderRadius: BorderRadius.circular(18.0),
          border: isPressed ? null : Border.all(color: primaryColors ,width: 1,),
        ),
        child: Center(
          child: Text(
            widget.titleProduct,
            style: GoogleFonts.arsenal(
              color: isPressed ? white : primaryColors,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
        ),
      ),
    );
  }
}
