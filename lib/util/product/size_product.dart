import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class SizeProducts extends StatefulWidget {
  final String titleSize;
  const SizeProducts({super.key, required this.titleSize});

  @override
  State<SizeProducts> createState() => _SizeProductsState();
}

class _SizeProductsState extends State<SizeProducts> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
            widget.titleSize,
            style: TextStyle(
              color: isPressed ? white : primaryColors,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}