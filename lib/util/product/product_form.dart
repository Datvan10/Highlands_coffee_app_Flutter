import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ProductForm extends StatelessWidget {
  final Products product;
  final VoidCallback onTap;

  const ProductForm({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(15.0)),
        // Customize your card widget based on the product details
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product information (e.g., image, name, etc.)
            // Example:
            Image.network(product.imagePath),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.arsenal(
                      color: black, fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.oldPrice.toStringAsFixed(3) + 'đ',
                      style: GoogleFonts.roboto(
                          color: grey,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    //new price
                    Text(
                      product.newPrice.toStringAsFixed(3) + 'đ',
                      style: GoogleFonts.roboto(
                          color: primaryColors,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  // padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: primaryColors, shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: white,
                  ),
                )
              ],
            )
            // Add other product details as needed
          ],
        ),
      ),
    );
  }
}
