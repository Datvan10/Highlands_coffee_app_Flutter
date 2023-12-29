import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
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
  late Map<String, dynamic> userData = {};
  int totalQuantity = 0;
  late double totalPrice = 0.0;
  String selectedPaymentMethod = '';
  //
  final _textDiscountCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTotalQuantity();
    fetchTotalPrice();
  }

  //
  Future<void> getTotalQuantity() async {
    QuerySnapshot<Map<String, dynamic>> cartSnapshot =
        await FirebaseFirestore.instance.collection('Giỏ hàng').get();

    int total = cartSnapshot.docs.fold(0, (total, doc) {
      return total + (doc.data()['quantity'] as int);
    });

    setState(() {
      totalQuantity = total;
    });
  }

  //
  Future<void> fetchTotalPrice() async {
    // Fetch the cart items from the Firestore collection
    QuerySnapshot<Map<String, dynamic>> cartSnapshot =
        await FirebaseFirestore.instance
            .collection('Giỏ hàng') // Change to your collection name
            .get();

    // Calculate the total price from the cart items
    double total = cartSnapshot.docs.fold(0.0, (total, doc) {
      return total + (doc.data()['totalPrice'] as double);
    });

    setState(() {
      totalPrice = total;
    });
  }

  // Hàm để tạo mã đơn hàng
  String generateOrderId() {
    // Bạn có thể tùy chỉnh mã đơn hàng theo nhu cầu của mình, ví dụ như kết hợp thời gian và một số ngẫu nhiên
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String randomPart = Random().nextInt(1000).toString().padLeft(3, '0');
    return 'ORDER_$timestamp$randomPart';
  }

  // Hàm để lưu thông tin đơn hàng vào cơ sở dữ liệu
  Future<void> _placeOrder() async {
  // Lấy thông tin người dùng từ InformationForm
  Map<String, dynamic> userInfo = await getUserData('2vPCzLR6LNVRi8uHXPV0');
  // Lấy chỉ các trường cần thiết từ userInfo
  String userName = userInfo?['userName'] ?? '';
  int phoneNumber = userInfo?['phoneNumber'] ?? 0;
  String address = userInfo?['address'] ?? '';

  // Lấy thông tin từ giỏ hàng
  QuerySnapshot<Map<String, dynamic>> cartSnapshot =
      await FirebaseFirestore.instance.collection('Giỏ hàng').get();

  List<Map<String, dynamic>> products = cartSnapshot.docs
      .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data() ?? {})
      .toList();

  // Kiểm tra nếu giỏ hàng không có sản phẩm
  if (products.isEmpty) {
    _showAlert('Lỗi', 'Đơn hàng không có sản phẩm để đặt hàng.');
    return;
  }

  // Tạo một đơn hàng mới với mã đơn hàng
  String orderId = generateOrderId();
  // Tạo một đơn hàng mới
  await FirebaseFirestore.instance.collection('Đơn hàng').add({
    'Mã đơn hàng': orderId,
    'Thông tin khách hàng': {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'address': address,
    },
    'Sản phẩm': products,
    'Số lượng sản phẩm': totalQuantity,
    'Tổng tiền': totalPrice,
    'Phương thức thanh toán': selectedPaymentMethod,
    'Trạng thái': 'Đang chờ duyệt', // Thêm trường trạng thái ở đây
    'Thời gian đặt hàng': FieldValue.serverTimestamp(),
    // Thêm các trường khác cần thiết
  });
  _showAlert('Thông báo', 'Đơn hàng được đặt thành công.');

  // Xóa giỏ hàng sau khi đặt hàng thành công
  await FirebaseFirestore.instance.collection('Giỏ hàng').get().then(
    (snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    },
  );
}



  //
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .get();

      if (userSnapshot.exists) {
        return userSnapshot.data() ?? {};
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

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
  void _showPayForm(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Số lượng',
                            style: GoogleFonts.arsenal(
                                fontSize: 18.0,
                                color: primaryColors,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('$totalQuantity',
                              style: GoogleFonts.arsenal(
                                  color: primaryColors, fontSize: 16))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phương thức',
                              style: GoogleFonts.arsenal(
                                  fontSize: 18.0,
                                  color: primaryColors,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            '$selectedPaymentMethod',
                            style: GoogleFonts.arsenal(
                                color: primaryColors, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Khuyến mãi',
                              style: GoogleFonts.arsenal(
                                  fontSize: 18.0,
                                  color: primaryColors,
                                  fontWeight: FontWeight.bold)),
                          Text('0đ',
                              style: GoogleFonts.arsenal(
                                  color: primaryColors, fontSize: 16))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng',
                          style: GoogleFonts.arsenal(
                              fontSize: 18.0,
                              color: primaryColors,
                              fontWeight: FontWeight.bold)),
                      Text('${totalPrice.toStringAsFixed(3)}đ',
                          style: GoogleFonts.arsenal(
                              fontSize: 21.0,
                              color: primaryColors,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  //
                  MyButton(
                    text: 'Đặt hàng',
                    onTap: () {
                      _placeOrder();
                    },
                    buttonColor: primaryColors,
                  )
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
              MyButton(
                text: 'Xác nhận',
                onTap: () {
                  // setState(() {
                  //   _showPayFormForm(context);
                  // });
                  Navigator.pop(context);
                  _showPayForm(context);
                },
                buttonColor: primaryColors,
              )
            ],
          ),
        );
      },
    );
  }

  //
  //
  void _showAlert(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: GoogleFonts.arsenal(color: primaryColors),
          ),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed('/home_page');
              },
              child: Text(
                'OK',
                style: TextStyle(color: blue),
              ),
            ),
          ],
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
          // Trong BillPage, tại nơi sử dụng InformationForm
          InformationForm(userId: '2vPCzLR6LNVRi8uHXPV0'),

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
          PaymentMethodForm(
            onPaymentMethodSelected: (method) {
              // Update the selected payment method
              setState(() {
                selectedPaymentMethod = method;
              });
            },
          ),
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
              GestureDetector(
                onTap: () {
                  _showConfirmForm(context);
                },
                child: Text(
                  'Chọn khuyến mãi',
                  style: GoogleFonts.arsenal(color: blue, fontSize: 15),
                ),
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
                'Thành tiền : ${totalPrice.toStringAsFixed(3)}đ',
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
          MyButton(
            text: 'Xác nhận',
            onTap: () {
              _showPayForm(context);
            },
            buttonColor: primaryColors,
          )
        ]),
      ),
    );
  }
}
