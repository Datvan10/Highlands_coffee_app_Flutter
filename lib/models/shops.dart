import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/models/products.dart';

class Shops {
  final List<Products> _productMenu = [
    Products(
      name: 'PHINDI CHOCO',
      description:
          'PhinDi Choco - với chất Phin êm hơn, kết hợp cùng Choco ngọt tan mang đến hương vị mới lạ, không thể hấp dẫn hơn!',
      imagePath: 'assets/images/coffee/phindi-choco.jpg',
      imageDetailPath: 'assets/images/detail/phindi-choco-detail.jpg',
      oldPrice: 75.000,
      newPrice: 45.000,
      rating: '4.9',
    ),
    Products(
      name: 'PHIN SỮA ĐÁ',
      description:
          'Phin sữa đá - phối trộn độc đáo giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng.',
      imagePath: 'assets/images/coffee/phin-sua-da.jpg',
      imageDetailPath: 'assets/images/detail/phin-sua-da-detail.jpg',
      oldPrice: 35.000,
      newPrice: 29.000,
      rating: '4.8',
    ),
  ];

  //customer cart
  List<Products> _cart = [];

  //getter methods
  List<Products> get productMenu => _productMenu;
  List<Products> get cart => _cart;

  //add to Cart
  void addToCart(Products productItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(productItem);
    }
    NotificationListener;
  }

  //remove from Cart
  void removeFromCart(Products product) {
    _cart.remove(product);
    NotificationListener;
  }
}
