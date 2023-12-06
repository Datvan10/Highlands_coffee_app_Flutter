import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/pages/coffee_page.dart';
import 'package:highlandcoffeeapp/components/pages/freeze_page.dart';
import 'package:highlandcoffeeapp/components/pages/other_page.dart';
import 'package:highlandcoffeeapp/components/pages/product_popular_page.dart';
import 'package:highlandcoffeeapp/components/pages/sweet_cake_page.dart';
import 'package:highlandcoffeeapp/components/pages/tea_page.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';
import 'package:highlandcoffeeapp/util/product/product_type.dart';
import 'package:highlandcoffeeapp/util/slide/slide_image.dart';
import 'package:permission_handler/permission_handler.dart';

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
  //list hot product
  List productHot = [
    Products(
        name: 'FREEZE TRÀ XANH',
        description: '',
        imagePath: 'assets/images/freeze/freeze-tra-xanh.jpg',
        imageDetailPath: '',
        oldPrice: 4.5,
        newPrice: 55.000,
        rating: '5.0'),
    Products(
        name: 'COOKIES & CREAM',
        description: '',
        imagePath: 'assets/images/freeze/cookies-cream.jpg',
        imageDetailPath: '',
        oldPrice: 6.5,
        newPrice: 3.5,
        rating: '4.9')
  ];
  //naviagte to product details page
  void _naviagteToProductsDetails(int index) {
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

  //
  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      // Yêu cầu quyền truy cập
      await Permission.microphone.request();
    }
  }

//
  void _startListening() async {
    await _requestMicrophonePermission();

    if (await Permission.microphone.isGranted) {
      // Quyền đã được cấp, bắt đầu lắng nghe
      // Sử dụng speech_to_text để thực hiện thu âm
    } else {
      // Người dùng từ chối cấp quyền
      // Xử lý tương ứng, ví dụ hiển thị thông báo
      print("Người dùng từ chối cấp quyền truy cập vào microphone");
    }
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
                hintText: 'Tìm kiếm đồ uống của bạn...',
                contentPadding: EdgeInsets.symmetric(),
                alignLabelWithHint: true,
                filled: true,
                fillColor: white,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                //icon search with microphone
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    size: 20,
                  ),
                  onPressed: _startListening,
                ),
                //icon clear
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
                //           _textSearchController.clear();
                //         },100
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
                ProductType(
                  titleProduct: 'Cà phê',
                  destinationPage: CoffeePage(),
                ),
                ProductType(
                  titleProduct: 'Freeze',
                  destinationPage: FreezePage(),
                ),
                ProductType(
                  titleProduct: 'Trà',
                  destinationPage: TeaPage(),
                ),
                ProductType(
                  titleProduct: 'Bánh ngọt',
                  destinationPage: SweetCakePage(),
                ),
                ProductType(
                  titleProduct: 'Khác',
                  destinationPage: OtherPage(),
                )
              ],
            ),
            SizedBox(height: 40),
            //product popular
            Column(
              children: [
                Container(
                  height: 300, // Đặt chiều cao cố định cho GridView
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18.0,
                      childAspectRatio: 0.64,
                    ),
                    itemCount: productPopular.length,
                    itemBuilder: (context, index) => ProducForm(
                      product: productPopular[index],
                      onTap: () => _naviagteToProductsDetails(index),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                //more product popular
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/product_popular_page');
                      },
                      child: Text(
                        'Xem thêm >>',
                        style: GoogleFonts.arsenal(color: blue, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // hot product
            Text('ĐỒ UỐNG HÓT',
                style: GoogleFonts.arsenal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColors)),
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
