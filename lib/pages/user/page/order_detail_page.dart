import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class OrderDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp  timestamp = order['Thời gian đặt hàng'];
    // Hàm giúp lấy tên tháng từ số tháng (1 đến 12)
    String _getMonthName(int month) {
      List<String> monthNames = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return monthNames[month];
    }

// Hàm giúp định dạng giờ (12 giờ)
    String _formatHour(int hour) {
      return hour > 12 ? (hour - 12).toString() : hour.toString();
    }

// Hàm giúp định dạng phút (thêm số 0 phía trước nếu nhỏ hơn 10)
    String _formatMinute(int minute) {
      return minute < 10 ? '0$minute' : minute.toString();
    }

// Hàm giúp lấy chu kỳ (AM hoặc PM)
    String _getPeriod(int hour) {
      return hour >= 12 ? 'PM' : 'AM';
    }

    // Chuyển đổi timestamp thành đối tượng DateTime
    DateTime dateTime = timestamp.toDate();

// Định dạng ngày và thời gian
    String formattedDateTime =
        '${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year} at ${_formatHour(dateTime.hour)}:${_formatMinute(dateTime.minute)} ${_getPeriod(dateTime.hour)}';

    // Xây dựng giao diện hiển thị chi tiết đơn hàng
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
        title: Text('Chi tiết đơn hàng',
            style: GoogleFonts.arsenal(
                color: primaryColors, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mã đơn hàng : ${order['Mã đơn hàng']}', style: GoogleFonts.arsenal(color: blue, fontSize: 18),),

            // Hiển thị các thông tin khác tùy ý
            Text('Thời gian đặt hàng: $formattedDateTime'),

            // Hiển thị thông tin sản phẩm
            Text('Thông tin sản phẩm :'),
            for (var product in order['Sản phẩm'] as List<dynamic>)
              Text(
                  '     Tên sản phẩm : ${product['productName']}, Số lượng : ${product['quantity']}'),
            // Hiển thị thông tin khách hàng
            Text('Thông tin khách hàng :'),
            Text(
                '     Tên khách hàng : ${order['Thông tin khách hàng']['userName']}'),
            Text(
                '     Số điện thoại : +84 ${order['Thông tin khách hàng']['phoneNumber']}'),
            Text('     Địa chỉ: ${order['Thông tin khách hàng']['address']}'),
            Text('Trạng thái đơn hàng : ${order['Trạng thái']}'),
            Text('Phương thức thanh toán : ${order['Phương thức thanh toán']}'),
            Text('Tổng tiền : ${order['Tổng tiền'].toStringAsFixed(3) + 'đ'}', style: GoogleFonts.arsenal(color: primaryColors, fontSize: 22, fontWeight: FontWeight.bold),),

            // Thêm các thông tin khác tùy ý
            SizedBox(height: 470,),
            MyButton(text: 'Hoàn thành', onTap: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
            }, buttonColor: blue)
          ],
        ),
      ),
    );
  }
}
