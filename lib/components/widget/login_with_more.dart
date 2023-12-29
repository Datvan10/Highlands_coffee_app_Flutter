import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class LoginWithMore extends StatelessWidget {
  final imagePath;
  const LoginWithMore({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(50),
        color: white,
      ),
      child: Image.asset(imagePath, height: 30,),
    );
  }
}