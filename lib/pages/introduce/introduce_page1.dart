import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_next.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class IntroducePage1 extends StatelessWidget {
  const IntroducePage1({super.key});
  final String hello = 'Xin chào!';
  final String imagePath = 'assets/images/coffee/phin-sua-da.jpg';
  final String title = 'Thương hiệu bắt nguồn từ cà phê Việt Nam';
  final String description =
      'Những ly cà phê của chúng tôi không chỉ đơn thuần là thức uống quen thuộc mà còn mang trên mình một sư mệnh văn hóa phản ánh một phần nếp sống hiện đại của người Việt Nam.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hello,
                style: GoogleFonts.playfairDisplay(
                  color: black_red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Image.asset(imagePath),
            Text(title,
                style: TextStyle(
                    color: brown, fontSize: 20, fontStyle: FontStyle.italic)),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SKIP',
                  style: TextStyle(color: primaryColors),
                ),
                ButtonNext(
                    text: 'NEXT',
                    onTap: () {
                      Get.toNamed('/introduce_page2');
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}