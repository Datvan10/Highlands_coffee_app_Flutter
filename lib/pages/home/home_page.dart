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
  final _textController = TextEditingController();

  //list popular product
  List productPopular = [
    Products(
      name: 'PHINDI CHOCO',
      imagePath: 'assets/images/coffee/phindi-choco.jpg',
      oldPrice: '75.000',
      newPrice: '45.000',
      rating: '4.9',
    ),
    Products(
      name: 'PHIN SỮA ĐÁ',
      imagePath: 'assets/images/coffee/phin-sua-da.jpg',
      oldPrice: '35.000',
      newPrice: '28.000',
      rating: '4.8',
    ),
  ];
  //list hot product
  List productHot = [
    Products(
      name: 'FREEZE TRÀ XANH', 
      imagePath: 'assets/images/freeze/freeze-tra-xanh.jpg', 
      oldPrice: 'oldPrice', 
      newPrice: '55.000', 
      rating: '5.0'),
    Products(
      name: 'COOKIES & CREAM', 
      imagePath: 'assets/images/freeze/cookies-cream.jpg', 
      oldPrice: 'oldPrice', 
      newPrice: '55.000', 
      rating: '4.9')
  ];
  //naviagte to product details page
  void naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productPopular[index],
    ));
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
            controller: _textController,
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
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: background, shape: BoxShape.circle),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 10,
                        ),
                        onPressed: () {
                          _textController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //slide adv
          Padding(
            padding: const EdgeInsets.only(left: 17.0, top: 17.0, right: 17.0),
            child: SlideImageHomePage(
              height: 180,
            ),
          ),
          SizedBox(height: 10),
          //product types
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductType(titleProduct: 'Cà phê'),
                ProductType(titleProduct: 'Freeze'),
                ProductType(titleProduct: 'Trà'),
                ProductType(titleProduct: 'Bánh mì'),
                ProductType(titleProduct: 'Khác')
              ],
            ),
          ),
          SizedBox(height: 40),
          //product popular
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productPopular.length,
                itemBuilder: (context, index) => ProductPopular(
                      product: productPopular[index],
                      onTap: () => naviagteToProductsDetails(index),
                    )),
          ),
          SizedBox(height: 15.0,),
          //more product popular
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Xem thêm >>', style: TextStyle(color: blue),)
              ],
            ),
          ),
          // hot product
          Padding(
            padding: const EdgeInsets.only(left : 17.0),
            child: Text('ĐỒ UỐNG HÓT', style: GoogleFonts.playfairDisplay( color: primaryColors, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          
        ],
      ),
    );
  }
}
