import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class FeddBackPage extends StatefulWidget {
  static const String routeName = '/feddback_page';
  const FeddBackPage({super.key});

  @override
  State<FeddBackPage> createState() => _FeddBackPageState();
}

class _FeddBackPageState extends State<FeddBackPage> {
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
                'Đánh giá bình luận',
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
