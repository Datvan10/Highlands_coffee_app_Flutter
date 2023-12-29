import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/pages/user/page/order_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/home_page');
                },
                icon: Icon(Icons.home),
              ))
        ],
        title: Text('Đơn hàng của tôi',
            style: GoogleFonts.arsenal(
                color: primaryColors, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Đơn hàng')
            .orderBy('Thời gian đặt hàng', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<QueryDocumentSnapshot> orders = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 800,
                decoration: BoxDecoration(
                  color: background
                ),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var order = orders.reversed.toList()[index];
                    int orderNumber = index + 1; // Số thứ tự của đơn hàng
                    return Container(
                      height:100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: white
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Đơn hàng $orderNumber', style: GoogleFonts.arsenal(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColors),),
                            Text('Mã đơn hàng : ${order['Mã đơn hàng']}'),
                            Text('Tổng tiền : ${order['Tổng tiền'].toStringAsFixed(3) + 'đ'}'),
                            // Thêm các thông tin khác tùy ý
                          ],
                        ),
                        onTap: () {
                          // Xử lý khi bấm vào một đơn hàng để xem chi tiết
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

