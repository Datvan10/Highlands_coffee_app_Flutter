import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ButtonNext extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const ButtonNext({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: primaryColors
          ),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: GoogleFonts.arsenal(color: white, fontSize: 16, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}