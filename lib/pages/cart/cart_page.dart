import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Giỏ hàng', style: TextStyle(color: primaryColors,),),
      ),
      body: Column(
        children: [
          //text notification
          Center(child: Text('Miễn phí vận chuyển với đơn hàng trên 300.000đ', style: TextStyle(color: grey),))
        ],
      ),
    );
  }
}