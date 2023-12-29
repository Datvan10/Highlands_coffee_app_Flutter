import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class PaymentMethodForm extends StatefulWidget {
   final Function(String) onPaymentMethodSelected;
  const PaymentMethodForm({super.key, required this.onPaymentMethodSelected});

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
        color: white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildPaymentOption('Thanh toán khi nhận hàng', 'Thanh toán khi nhận hàng'),
          buildPaymentOption('Thanh toán bằng thẻ tín dụng', 'Thanh toán bằng thẻ tín dụng'),
          buildPaymentOption('Chuyển khoản ngân hàng', 'Chuyển khoản ngân hàng'),
          buildPaymentOption('Ví điện tử', 'Ví điện tử'),
        ],
      ),
    );
  }

  Widget buildPaymentOption(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.arsenal(fontSize: 17, color: black),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 9.0),
      leading: Radio(
        value: value,
        groupValue: selectedPaymentOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedPaymentOption = newValue!;
            // Call the callback function with the selected payment option
            widget.onPaymentMethodSelected(selectedPaymentOption);
          });
        },
        activeColor: primaryColors,
      ),
    );
  }
}
