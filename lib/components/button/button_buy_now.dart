import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ButtonBuyNow extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const ButtonBuyNow({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: 160,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColors,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}