import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/product/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_popular.dart';
import 'package:highlandcoffeeapp/util/product/product_type.dart';
import 'package:highlandcoffeeapp/util/slide/slide_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndexBottomBar = 0;
  final _textSearchController = TextEditingController();

  //list popular product
  List productPopular = [
    Products(
      name: 'PHINDI CHOCO',
      description : 'PhinDi Choco - với chất Phin êm hơn, kết hợp cùng Choco ngọt tan mang đến hương vị mới lạ, không thể hấp dẫn hơn!',
      imagePath: 'assets/images/coffee/phindi-choco.jpg',
      imageDetailPath : 'assets/images/detail/phindi-choco-detail.jpg',
      oldPrice: 75.000,
      newPrice: 45.000,
      rating: '4.9',
    ),
    Products(
      name: 'PHIN SỮA ĐÁ',
      description : '',
      imagePath: 'assets/images/coffee/phin-sua-da.jpg',
      imageDetailPath : '',
      oldPrice: 35.000,
      newPrice: 28.000,
      rating: '4.8',
    ),
  ];
  //list hot product
  List productHot = [
    Products(
      name: 'FREEZE TRÀ XANH',
      description : '',
      imagePath: 'assets/images/freeze/freeze-tra-xanh.jpg',
      imageDetailPath : '',
      oldPrice: 4.5,
      newPrice: 55.000,
      rating: '5.0'),
    Products(
      name: 'COOKIES & CREAM',
      description : '',
      imagePath: 'assets/images/freeze/cookies-cream.jpg',
      imageDetailPath : '',
      oldPrice: 6.5,
      newPrice: 3.5,
      rating: '4.9')
  ];
  //naviagte to product details page
  void naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productPopular[index],
    ));
  }

  //SelectedBottomBar
  void _selectedBottomBar(int index) {
    setState(() {
      _selectedIndexBottomBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColors,
        title: Container(
          height: 40,
          child: TextField(
            controller: _textSearchController,
            decoration: InputDecoration(
                hintText: 'Tìm đồ uống của bạn...',
                contentPadding: EdgeInsets.symmetric(),
                alignLabelWithHint: true,
                filled: true,
                fillColor: white,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                // suffixIcon: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: 20,
                //     height: 20,
                //     decoration: BoxDecoration(
                //         color: background, shape: BoxShape.circle),
                //     child: Center(
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.clear,
                //           size: 10,
                //         ),
                //         onPressed: () {
                //           _textSearchControllerq`1                                                                                                         ````````````````````````````````````qq.clear();
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //slide adv
            SlideImageHomePage(
              height: 180,
            ),
            SizedBox(height: 10),
            //product types
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductType(titleProduct: 'Cà phê'),
                ProductType(titleProduct: 'Freeze'),
                ProductType(titleProduct: 'Trà'),
                ProductType(titleProduct: 'Bánh mì'),
                ProductType(titleProduct: 'Khác')
              ],
            ),
            SizedBox(height: 40),
            //product popular
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int index = 0; index < min(2, productPopular.length); index++)
                    ProductPopular(
                      product: productPopular[index],
                      onTap: () => naviagteToProductsDetails(index),
                    ),
                ],
              ),
            // show with ListView
            // Expanded(
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: productPopular.length,
            //       itemBuilder: (context, index) => ProductPopular(
            //             product: productPopular[index],
            //             onTap: () => naviagteToProductsDetails(index),
            //           )),
            // ),
            SizedBox(height: 15.0,),
            //more product popular
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Xem thêm >>', style: TextStyle(color: blue),)
              ],
            ),
            // hot product
            Text('ĐỒ UỐNG HÓT', style: GoogleFonts.playfairDisplay( color: primaryColors, fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      //bottom bar
      // bottomNavigationBar: BottomNavigationBar(
      //       backgroundColor: Colors.transparent,
      //       elevation: 0,
      //       selectedItemColor: primaryColors,
      //       type: BottomNavigationBarType.fixed,
      //       currentIndex: _selectedIndexBottomBar,
      //       onTap: _selectedBottomBar,
      //       items: const [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: 'Trang chu',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.favorite),
      //           label: 'Favorite',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.shopping_cart),
      //           label: 'Carts',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           label: 'Profile',
      //         ),
      //       ]),
    );
  }
}
