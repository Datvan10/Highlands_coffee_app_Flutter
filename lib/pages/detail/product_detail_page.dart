import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/models/product/products.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        // automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
        ],
        ),
      body: Column(),
    );
  }
}