import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/models/users.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class InformationForm extends StatelessWidget {
  // final Users user;
  const InformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: primaryColors,)
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: primaryColors,)
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone, color: primaryColors,)
              ],
            )
          ],
        ),
      ),
    );
  }
}