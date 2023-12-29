import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/button_next.dart';
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
        padding: const EdgeInsets.only(left: 28.0, top: 50.0, right: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hello,
                style: GoogleFonts.arsenal(
                  color: black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Image.asset(imagePath),
            Text(title,
                style: GoogleFonts.arsenal(
                    color: brown, fontSize: 25, fontStyle: FontStyle.italic)),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: GoogleFonts.arsenal(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   'BACK',
                //   style: GoogleFonts.arsenal(color: primaryColors, fontSize: 16, fontWeight: FontWeight.bold),
                // ),
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
