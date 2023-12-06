import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_payment.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/bill/information_form.dart';
import 'package:highlandcoffeeapp/util/bill/payment_method_form.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColors,
            )),
        title: Text(
          'Hóa đơn',
          style: GoogleFonts.arsenal(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: primaryColors),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin nhận hàng',
                style: GoogleFonts.arsenal(
                    fontSize: 18,
                    color: primaryColors,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Thay đổi',
                style: GoogleFonts.arsenal(color: blue, fontSize: 15),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          //
          InformationForm(),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Phương thức thanh toán',
            style: GoogleFonts.arsenal(
                fontSize: 18,
                color: primaryColors,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          //
          PaymentMethodForm(),
          SizedBox(
            height: 15,
          ),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Khuyến mãi',
                style: GoogleFonts.arsenal(
                    fontSize: 18,
                    color: primaryColors,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Chọn khuyến mãi',
                style: GoogleFonts.arsenal(color: blue, fontSize: 15),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Thành tiền : ',
                style: GoogleFonts.arsenal(
                    fontSize: 18,
                    color: primaryColors,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 150,
          ),
          //
          ButtonPayment(text: 'Thanh toán', onTap: () {})
        ]),
      ),
    );
  }
}
