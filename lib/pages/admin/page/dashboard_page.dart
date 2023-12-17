import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard_page';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text('Tổng quan', style: GoogleFonts.arsenal(fontSize: 30, color: primaryColors, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}