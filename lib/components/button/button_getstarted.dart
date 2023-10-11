import 'package:flutter/material.dart';

class ButtonGetStarted extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const ButtonGetStarted({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.white
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,),
              const SizedBox(width: 10.0,),
              const Icon(Icons.arrow_forward, color: Colors.black,)
            ],
          ),
        ),
      ),
    );
  }
}