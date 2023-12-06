import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ButtonAuthentication extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const ButtonAuthentication({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColors,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.arsenal(color: white, fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
        ),
      ),
    );
  }
}