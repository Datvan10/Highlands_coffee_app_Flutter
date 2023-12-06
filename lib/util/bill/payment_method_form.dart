import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class PaymentMethodForm extends StatefulWidget {
  const PaymentMethodForm({super.key});

  @override
  State<PaymentMethodForm> createState() => _PaymentMethodFormState();
}

class _PaymentMethodFormState extends State<PaymentMethodForm> {
  String selectedPaymentOption = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildPaymentOption('Thanh toán bằng tiền mặt', 'cash'),
          buildPaymentOption('Thanh toán bằng thẻ tín dụng', 'credit_card'),
          buildPaymentOption('Chuyển khoản ngân hàng', 'bank_transfer'),
          buildPaymentOption('Ví điện tử', 'e_wallet')
        ],
      ),
    );
  }

  Widget buildPaymentOption(String title, String value) {
    return ListTile(
      title: Text(title, style: GoogleFonts.arsenal(fontSize: 17, color: black),),
      contentPadding: EdgeInsets.symmetric(horizontal: 9.0),
      leading: Radio(
        value: value,
        groupValue: selectedPaymentOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedPaymentOption = newValue!;
          });
        },
        activeColor: primaryColors,
      ),
    );
  }
}
