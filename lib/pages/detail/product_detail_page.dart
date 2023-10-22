import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_add_to_cart.dart';
import 'package:highlandcoffeeapp/components/button/button_buy_now.dart';
import 'package:highlandcoffeeapp/models/product/products.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/size_product.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantityCount = 1; //quantity
  double totalPrice = 0.0; // total price

  @override
  void initState() {
    super.initState();
    updateTotalPrice();
  }

  //
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
        quantityCount--;
        updateTotalPrice();
      }
    });
  }

  //
  void incrementQuantity() {
    setState(() {
      quantityCount++;
      updateTotalPrice();
    });
  }

  // // initialization variable total price
  // double totalPrice = 0.0;

  void updateTotalPrice() {
    setState(() {
      double productPrice = widget.product.newPrice;
      totalPrice = productPrice * quantityCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: primaryColors,
      //   // automaticallyImplyLeading: false,
      //   elevation: 0,
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
      //   ],
      //   ),
      body: Column(
        children: [
          Expanded(
              child: Image.asset(
            widget.product.imageDetailPath,
            fit: BoxFit.fill,
          )),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                //product name and icon favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.product.name,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColors),
                    ),
                    // IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
                    Image.asset('assets/icons/heart.png', width: 25, color: primaryColors,)
                  ],
                ),
                //product image and description
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.product.imagePath,
                        width: 90,
                        height: 90,
                      ),
                      Expanded(
                        child: Text(
                          widget.product.description,
                          style: TextStyle(color: black_red, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product size
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chọn Size',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: brown),
                      ),
                      SizeProducts(titleSize: 'S'),
                      SizeProducts(titleSize: 'M'),
                      SizeProducts(titleSize: 'L'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product quantity
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        'Số lượng',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: brown),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: primaryColors, shape: BoxShape.circle),
                            child: GestureDetector(
                              onTap: decrementQuantity,
                              child: Icon(Icons.remove, size: 18, color: white,),
                            )
                          ),
                          //quantity + count
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                quantityCount.toString(),
                                style: TextStyle(
                                    color: brown,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: primaryColors, shape: BoxShape.circle),
                            child: GestureDetector(
                              onTap: incrementQuantity,
                              child: Icon(Icons.add, size: 18, color: white,),
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product price
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        'Tổng tiền',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: brown),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        totalPrice.toStringAsFixed(3) + 'đ',
                        style: TextStyle(
                            color: primaryColors,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //button add to cart and buy now
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonAddToCart(text: 'Thêm vào giỏ', onTap: () {}),
                        VerticalDivider(
                          color: light_grey,
                          thickness: 1,
                        ),
                        ButtonBuyNow(text: 'Mua ngay', onTap: () {}),
                      ],
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(color: white),
          )),
        ],
      ),
    );
  }
}
