import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_authentication.dart';
import 'package:highlandcoffeeapp/components/button/button_payment.dart';
import 'package:highlandcoffeeapp/models/tickets.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/bill/discount_code_form.dart';
import 'package:highlandcoffeeapp/util/bill/information_form.dart';
import 'package:highlandcoffeeapp/util/bill/payment_method_form.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  //
  final _textDiscountCodeController = TextEditingController();

  List discountTickets = [
    Tickets(
        imagePath: 'assets/images/ticket/discount_code_tea_freeze.jpg',
        name: 'TEAFREEZEAJX01',
        description: 'Ưu đãi 30% cho Trà & Freeze',
        date: 'Đến hết ngày 30/12/2023',
        titleUse: 'Áp Dụng'),
    Tickets(
        imagePath: 'assets/images/ticket/discount_code_freeze.jpg',
        name: 'FREEZEFT05',
        description: 'Voucher giảm 50K cho tất cả Freeze',
        date: 'Đến hết ngày 30/1/2024',
        titleUse: 'Áp Dụng'),
    Tickets(
        imagePath: 'assets/images/ticket/discount_code_tea.jpg',
        name: 'TEAFJXN01',
        description: 'Ưu đãi mua 1 tặng 1 với các loại Trà',
        date: 'Đến hết ngày 28/1/2024',
        titleUse: 'Áp Dụng'),
    // Tickets(
    //     imagePath: 'assets/images/ticket/discount_code_1.jpg',
    //     name: 'PHINDIFAN01',
    //     description: 'Ưu đãi 30% cho PHinDi',
    //     date: 'Đến hết ngày 30/12/2023',
    //     titleUse: 'Áp Dụng')
  ];

  //
  void _showPayFormForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Chiều dài có thể được cuộn
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, top: 50.0, right: 18.0, bottom: 18.0),
              child: Column(
                children: [
                  //
                  Text(
                    'Xác nhận đơn hàng',
                    style: GoogleFonts.arsenal(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColors),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      Row(
                        children: [
                          Text('Số lượng', style: GoogleFonts.arsenal(fontSize: 18.0, color: primaryColors, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(
                    height: 15,
                  ),
                      //
                      Row(
                        children: [
                          Text('Phương thức', style: GoogleFonts.arsenal(fontSize: 18.0, color: primaryColors, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                    height: 15,
                  ),
                      //
                      Row(
                        children: [
                          Text('Khuyến mãi', style: GoogleFonts.arsenal(fontSize: 18.0, color: primaryColors, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //
                  Row(
                    children: [
                      Text('Tổng', style: GoogleFonts.arsenal(fontSize: 21.0, color: primaryColors, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 100,),
                  //
                  ButtonPayment(text: 'Thanh toán', onTap: (){})
                ],
              ),
            ),
          );
        });
  }

  //
  void _showConfirmForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Chiều dài có thể được cuộn
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 750,
          width: MediaQuery.of(context).size.width,
          // Nội dung của form sẽ ở đây
          padding:
              EdgeInsets.only(left: 18.0, top: 50.0, right: 18.0, bottom: 18.0),
          child: Column(
            children: [
              //
              Text(
                'Khyến mãi',
                style: GoogleFonts.arsenal(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColors),
              ),
              SizedBox(
                height: 30,
              ),
              //
              TextField(
                controller: _textDiscountCodeController,
                decoration: InputDecoration(
                    hintText: 'Nhập mã giảm giá',
                    contentPadding: EdgeInsets.symmetric(),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: white,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    //icon clear
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: background, shape: BoxShape.circle),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 10,
                            ),
                            onPressed: () {
                              _textDiscountCodeController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 35,
              ),
              //
              DiscountCodeForm(
                discountTickets: List<Tickets>.from(discountTickets),
              ),
              SizedBox(
                height: 35,
              ),
              ButtonAuthentication(
                  text: 'Xác nhận',
                  onTap: () {
                    // setState(() {
                    //   _showPayFormForm(context);
                    // });
                    Navigator.pop(context);
                    _showPayFormForm(context);
                  })
            ],
          ),
        );
      },
    );
  }

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
          ButtonPayment(
              text: 'Thanh toán',
              onTap: () {
                _showConfirmForm(context);
              })
        ]),
      ),
    );
  }
}
