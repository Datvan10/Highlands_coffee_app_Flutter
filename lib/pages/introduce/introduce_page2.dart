import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_next.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class IntroducePage2 extends StatelessWidget {
  const IntroducePage2({super.key});
  final String hello = 'Xin chào!';
  final String imagePath = 'assets/images/coffee/phindi-hat-de-cuoi.jpg';
  final String title = 'Kết nối hài hòa giữ truyền thống với hiện đại';
  final String description =
      'Đến nay, Highlands Coffee® vẫn duy trì khâu phân loại cà phê bằng tay để trọn ra từng hạt cà phê chất lượng nhất, rang mới mỗi ngày và phục vụ quý khách với nụ cười rạng rỡ trên môi.';

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
                style:
                    GoogleFonts.playfairDisplay(
                      color: black_red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
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
                ButtonNext(text: 'NEXT', onTap: () {
                  Get.toNamed('/home_page');
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
