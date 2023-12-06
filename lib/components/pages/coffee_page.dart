import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  List productsCoffee = [
    Products(
        name: 'AMERICANO',
        description:
            'Kết hợp từ cà phê truyền thống cùng với caramel, thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và caramel ngọt ngào.',
        imagePath: 'assets/images/coffee/americano.jpg',
        imageDetailPath: '',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.2'),
    Products(
        name: 'ESPRESSO',
        description: 'description',
        imagePath: 'assets/images/coffee/espresso.jpg',
        imageDetailPath: '',
        oldPrice: 35.000,
        newPrice: 28.000,
        rating: '4.3'),
    Products(
        name: 'CAPPUCCINO',
        description:
            'Trà xanh thượng hạng từ cao nguyên Việt Nam, kết hợp cùng đá xay, thạch trà dai dai, thơm ngon và một lớp kem dày phủ lên trên vô cùng hấp dẫn.',
        imagePath: 'assets/images/coffee/cappuccino.jpg',
        imageDetailPath: '',
        oldPrice: 65.000,
        newPrice: 55.000,
        rating: '4.9'),
    Products(
        name: 'LATE',
        description:
            'Sự kết hợp hoàn hảo giữa cookies sô cô la giòn xốp cùng hỗn hợp sữa tươi cùng sữa đặc đem say với đá viên, và lớp kem whip mềm mịn cùng cookies sô cô la say nhuyễn.',
        imagePath: 'assets/images/coffee/latte.jpg',
        imageDetailPath: '',
        oldPrice: 59.000,
        newPrice: 55.000,
        rating: '4.8'),
    Products(
        name: 'CARAMEL CAPPUCCINO',
        description:
            'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.',
        imagePath: 'assets/images/coffee/caramel-cappucino.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.4'),
    Products(
        name: 'MOCHA MACCHIATO',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/mocha-macchiato.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5'),
    Products(
        name: 'PHUN ĐEN ĐÁ',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/phin-den-da.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5'),
    Products(
        name: 'PHIN SỮA ĐÁ',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/phin-sua-da.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5'),
    Products(
        name: 'PHINDI KEM SỮA',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/phindi-kem-sua.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5'),
    Products(
        name: 'PHINDI HẠT DẺ CƯỜI',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/phindi-hat-de-cuoi.jpg',
        imageDetailPath: '',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5'),
    Products(
        name: 'PHINDI HẠNH NHÂN',
        description:
            'Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
        imagePath: 'assets/images/coffee/phindi-hanh-nhan.jpg',
        imageDetailPath: 'assets/images/detail/phindi-hanh-nhan-detail.jpg',
        oldPrice: 49.000,
        newPrice: 45.000,
        rating: '4.5')
  ];

//naviagte to product details page
  void _naviagteToProductsDetails(int index) {
    Get.to(ProductDetailPage(
      product: productsCoffee[index],
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
          'COFFEE',
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
              onPressed: () {},
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
                itemCount: productsCoffee.length,
                itemBuilder: (context, index) => ProducForm(
                  product: productsCoffee[index],
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
