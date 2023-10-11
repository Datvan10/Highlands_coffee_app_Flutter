import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ProductType extends StatefulWidget {
  final String titleProduct;

  const ProductType({super.key, required this.titleProduct});

  @override
  State<ProductType> createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Container(
        height: 25,
        width: 60,
        decoration: BoxDecoration(
          color: isPressed ? primaryColors : white,
          borderRadius: BorderRadius.circular(18.0),
          border: isPressed ? null : Border.all(color: primaryColors ,width: 1,),
        ),
        child: Center(
          child: Text(
            widget.titleProduct,
            style: TextStyle(
              color: isPressed ? white : primaryColors,
            ),
          ),
        ),
      ),
    );
  }
}
