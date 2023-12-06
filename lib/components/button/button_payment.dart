import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ButtonPayment extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const ButtonPayment(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColors,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.roboto(color: white, fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
