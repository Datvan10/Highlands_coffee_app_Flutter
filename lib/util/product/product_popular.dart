import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/models/product/products.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ProductPopular extends StatelessWidget {
  final Products product;
  final void Function()? onTap;
  const ProductPopular({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(15.0)),
        width: 185,
        height: 250,
        child: Column(
          children: [
            //image
            Image.asset(product.imagePath),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            //name product
            Text(product.name, style: TextStyle(color: black_red, fontSize: 15),),              //price and add to Carts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //old nad new price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //old price
                    Text(product.oldPrice.toStringAsFixed(3) + 'đ', style: TextStyle( color: grey, fontSize: 15,decoration: TextDecoration.lineThrough),),
                    //new price
                    Text(product.newPrice.toStringAsFixed(3) + 'đ', style: TextStyle(color: primaryColors, fontSize: 16, fontWeight: FontWeight.bold),)
                  ],
                ),
                //button add to carts
                Container(
                    // padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: primaryColors,
                        shape: BoxShape.circle
                        ),
                    child: Icon(Icons.add, color: white,),
                  )
              ],
            )
              ],
            )
            //rating
            ],
        ),
      ),
    );
  }
}
