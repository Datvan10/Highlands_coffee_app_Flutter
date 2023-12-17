import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';

class FreezePage extends StatefulWidget {
  const FreezePage({super.key});

  @override
  State<FreezePage> createState() => _FreezePageState();
}

class _FreezePageState extends State<FreezePage> {
  List productsFreeze = [
    Products(
        name: 'CARAMEL PHIN FREEZE',
        description:
            'Kết hợp từ cà phê truyền thống cùng với caramel, thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và caramel ngọt ngào.',
        imagePath: 'assets/images/freeze/caramel-phin-freeze.jpg',
        imageDetailPath: 'assets/images/detail/caramel-phin-freeze-detail.jpg',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.2'),
    Products(
        name: 'CLASSIC PHIN FREEZE',
        description: 'description',
        imagePath: 'assets/images/freeze/classic-phin-freeze.jpg',
        imageDetailPath: 'assets/images/detail/classic-phin-freeze-detail.jpg',
        oldPrice: 35.000,
        newPrice: 28.000,
        rating: '4.3'),
    Products(
        name: 'COOKIES CREAM',
        description:
            'Trà xanh thượng hạng từ cao nguyên Việt Nam, kết hợp cùng đá xay, thạch trà dai dai, thơm ngon và một lớp kem dày phủ lên trên vô cùng hấp dẫn.',
        imagePath: 'assets/images/freeze/cookies-cream.jpg',
        imageDetailPath: 'assets/images/detail/cookies-cream-detail.jpg',
        oldPrice: 65.000,
        newPrice: 55.000,
        rating: '4.9'),
    Products(
        name: 'FREEZE SOCOLA',
        description:
            'Sự kết hợp hoàn hảo giữa cookies sô cô la giòn xốp cùng hỗn hợp sữa tươi cùng sữa đặc đem say với đá viên, và lớp kem whip mềm mịn cùng cookies sô cô la say nhuyễn.',
        imagePath: 'assets/images/freeze/freeze-so-co-la.jpg',
        imageDetailPath: 'assets/images/detail/freeze-so-co-la-detail.jpg',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.8'),
    Products(
        name: 'FREEZE TRÀ XANH',
        description:
            'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.',
        imagePath: 'assets/images/freeze/freeze-tra-xanh.jpg',
        imageDetailPath: 'assets/images/detail/freeze-tra-xanh-detail.jpg',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.4'),
    Products(
        name: 'FREEZE QUẢ MỌNG ANH ĐÀO',
        description:
            'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.',
        imagePath: 'assets/images/freeze/freeze-qua-mong-anh-dao.jpg',
        imageDetailPath: 'assets/images/detail/freeze-qua-mong-anh-dao-detail.jpg',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.4'),
  ];

//naviagte to product details page
  void _naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productsFreeze[index],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'FREEZE',
          style: GoogleFonts.arsenal(
            color: primaryColors,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: primaryColors,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right : 8.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: primaryColors,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          // Các widgets trong body ở đây
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột
                  crossAxisSpacing: 18.0, // Khoảng cách giữa các cột
                  mainAxisSpacing: 18.0, // Khoảng cách giữa các hàng
                  childAspectRatio:
                      0.64, // Tỉ lệ chiều rộng so với chiều cao của mỗi phần tử
                ),
                itemCount: productsFreeze.length,
                itemBuilder: (context, index) => ProducForm(
                  product: productsFreeze[index],
                  onTap: () => _naviagteToProductsDetails(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
