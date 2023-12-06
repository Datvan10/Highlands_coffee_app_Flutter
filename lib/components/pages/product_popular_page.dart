import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';

class ProductPopularPage extends StatefulWidget {
  const ProductPopularPage({super.key});

  @override
  State<ProductPopularPage> createState() => _ProductPopularPageState();
}

class _ProductPopularPageState extends State<ProductPopularPage> {
  List productsPopular = [
    Products(
        name: 'CARAMEL PHIN FREEZE',
        description: 'Kết hợp từ cà phê truyền thống cùng với caramel, thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và caramel ngọt ngào.',
        imagePath: 'assets/images/freeze/caramel-phin-freeze.jpg',
        imageDetailPath: 'assets/images/detail/caramel-phin-freeze-detail.jpg',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.2'),
    Products(
        name: 'BÁNH MÌ GÀ NƯỚNG',
        description: 'description',
        imagePath: 'assets/images/bread/banh-mi-ga-nuong.jpg',
        imageDetailPath: 'imageDetailPath',
        oldPrice: 35.000,
        newPrice: 28.000,
        rating: '4.3'),
    Products(
        name: 'FREEZE TRÀ XANH',
        description:
            'Trà xanh thượng hạng từ cao nguyên Việt Nam, kết hợp cùng đá xay, thạch trà dai dai, thơm ngon và một lớp kem dày phủ lên trên vô cùng hấp dẫn.',
        imagePath: 'assets/images/freeze/freeze-tra-xanh.jpg',
        imageDetailPath: 'assets/images/detail/freeze-tra-xanh-detail.jpg',
        oldPrice: 65.000,
        newPrice: 55.000,
        rating: '4.9'),
    Products(
        name: 'COOKIES CREAM',
        description:
            'Sự kết hợp hoàn hảo giữa cookies sô cô la giòn xốp cùng hỗn hợp sữa tươi cùng sữa đặc đem say với đá viên, và lớp kem whip mềm mịn cùng cookies sô cô la say nhuyễn.',
        imagePath: 'assets/images/freeze/cookies-cream.jpg',
        imageDetailPath: 'imageDetailPath',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.8'),
    Products(
        name: 'TRÀ THẠCH ĐÀO',
        description:
            'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.',
        imagePath: 'assets/images/tea/tra-thach-dao.jpg',
        imageDetailPath: 'assets/images/detail/tra-thach-dao-datail.jpg',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.4'),
    Products(
        name: 'TRÀ SEN VÀNG CỦ NĂNG',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/tea/tra-sen-vang-cu-nang.jpg',
        imageDetailPath: 'assets/images/detail/tra-sen-vang-cu-nang-detail.jpg',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5')
  ];

//naviagte to product details page
  void _naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productsPopular[index],
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
          'Sản phẩm nổi bật',
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
          IconButton(
              onPressed: () {
                Get.toNamed('/cart_page');
              },
              icon: Icon(
                Icons.shopping_cart,
                color: primaryColors,
              ))
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
                itemCount: productsPopular.length,
                itemBuilder: (context, index) => ProducForm(
                  product: productsPopular[index],
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
