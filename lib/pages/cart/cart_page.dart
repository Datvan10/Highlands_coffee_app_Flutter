import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/cart/order_form.dart';

class CartPage extends StatefulWidget {
  final CartPageArguments arguments;

  const CartPage({required this.arguments});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = widget.arguments.cartItems;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Giỏ hàng',
            style: GoogleFonts.arsenal(
                color: primaryColors,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColors,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            //text notification
            Center(
                child: Text(
              'Miễn phí vận chuyển với đơn hàng trên 300.000đ',
              style: TextStyle(color: black),
            )),
            const SizedBox(
              height: 30,
            ),
           OrderForm(cartItems: cartItems),
            //button order now
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String productImage;
  final String productName;
  final double newPrice;
  final double totalPrice;
  final int quantity;
  final String selectedSize;

  CartItem(
      this.productImage, this.productName, this.newPrice, this.totalPrice, this.quantity, this.selectedSize);
}
