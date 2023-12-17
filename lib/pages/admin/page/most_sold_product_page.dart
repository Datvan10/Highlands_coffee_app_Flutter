import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class MostSoldProductPage extends StatefulWidget {
  static const String routeName = '/most_sold_product_page';
  const MostSoldProductPage({super.key});

  @override
  State<MostSoldProductPage> createState() => _MostSoldProductPageState();
}

class _MostSoldProductPageState extends State<MostSoldProductPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Sản phẩm bán chạy nhất',
                style: GoogleFonts.arsenal(
                    fontSize: 30,
                    color: primaryColors,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}