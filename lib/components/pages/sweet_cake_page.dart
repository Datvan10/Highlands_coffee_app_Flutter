import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';

class SweetCakePage extends StatefulWidget {
  const SweetCakePage({super.key});

  @override
  State<SweetCakePage> createState() => _SweetCakePageState();
}

class _SweetCakePageState extends State<SweetCakePage> {
  List productsCake = [
    Products(
        name: 'BÁNH MOUSSE CACAO',
        description:
            'Kết hợp từ cà phê truyền thống cùng với caramel, thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và caramel ngọt ngào.',
        imagePath: 'assets/images/cake/ca-cao-mousse.jpg',
        imageDetailPath: '',
        oldPrice: 59.000,
        newPrice: 35.000,
        rating: '4.2'),
    Products(
        name: 'BÁNH PHÔ MAI CÀ PHÊ',
        description: 'description',
        imagePath: 'assets/images/cake/ca-phe-pho-mai-mousse.jpg',
        imageDetailPath: '',
        oldPrice: 35.000,
        newPrice: 35.000,
        rating: '4.3'),
    Products(
        name: 'BÁNH CARAMEL PHÔ MAI',
        description:
            'Trà xanh thượng hạng từ cao nguyên Việt Nam, kết hợp cùng đá xay, thạch trà dai dai, thơm ngon và một lớp kem dày phủ lên trên vô cùng hấp dẫn.',
        imagePath: 'assets/images/cake/caramel-pho-mai.jpg',
        imageDetailPath: 'assets/images/detail/caramel-pho-mai-detail.jpg',
        oldPrice: 65.000,
        newPrice: 35.000,
        rating: '4.9'),
    Products(
        name: 'BÁNH PHÔ MAI TRÀ XANH',
        description:
            'Sự kết hợp hoàn hảo giữa cookies sô cô la giòn xốp cùng hỗn hợp sữa tươi cùng sữa đặc đem say với đá viên, và lớp kem whip mềm mịn cùng cookies sô cô la say nhuyễn.',
        imagePath: 'assets/images/cake/matcha-pho-mai.jpg',
        imageDetailPath: '',
        oldPrice: 59.000,
        newPrice: 35.000,
        rating: '4.8'),
    Products(
        name: 'BÁNH MOUSSE ĐÀO',
        description:
            'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.',
        imagePath: 'assets/images/cake/mousse-dao.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 35.000,
        rating: '4.4'),
    Products(
        name: 'BÁNH PHÔ MAI CHANH DÂY',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/cake/pho-mai-chanh-day.jpg',
        imageDetailPath: 'assets/images/detail/pho-mai-chanh-day-detail.jpg',
        oldPrice: 49.000,
        newPrice: 35.000,
        rating: '4.5'),
    Products(
        name: 'BÁNH TIRAMISU',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/cake/tiramisu.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 35.000,
        rating: '4.5'),
  ];

  //naviagte to product details page
  void _naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productsCake[index],
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
          'BÁNH NGỌT',
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
                itemCount: productsCake.length,
                itemBuilder: (context, index) => ProducForm(
                  product: productsCake[index],
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
