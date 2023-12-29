import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/pages/favorite_product_page.dart';
import 'package:highlandcoffeeapp/components/pages/list_product_page.dart';
import 'package:highlandcoffeeapp/components/widget/profile_menu_user.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/user/page/my_order_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({super.key});

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  int _selectedIndexBottomBar = 4;
  //
  void _selectedBottomBar(int index) {
    setState(() {
      _selectedIndexBottomBar = index;
    });
  }

  void showImage(BuildContext context) {
    // Tạm thời sử dụng đường dẫn ảnh cố định, bạn có thể thay thế bằng đường dẫn thực tế của ảnh bạn muốn hiển thị.
    String imagePath = 'assets/images/profile/profile_user.jpg';

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Ảnh'),
          content: Image.asset(imagePath),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog khi nhấn OK
              },
              child: Text(
                'Xong',
                style: TextStyle(color: blue),
              ),
            ),
          ],
        );
      },
    );
  }

  //
  void _showCameraModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          // title: Text('Chọn ảnh', style: TextStyle(color: blue)),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                // Xử lý khi người dùng chọn chụp ảnh
                Navigator.pop(context);
                // Gọi hàm để hiển thị ảnh
                showImage(context);
              },
              child: Text('Xem ảnh', style: TextStyle(color: blue)),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                // Xử lý khi người dùng chọn chụp ảnh
                Navigator.pop(context);
              },
              child: Text('Chụp ảnh', style: TextStyle(color: blue)),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                // Xử lý khi người dùng chọn ảnh từ thư viện
                Navigator.pop(context);
              },
              child:
                  Text('Chọn ảnh từ thư viện', style: TextStyle(color: blue)),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              // Xử lý khi người dùng nhấn nút hủy bỏ
              Navigator.pop(context);
            },
            child: Text('Hủy', style: TextStyle(color: blue)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDrak = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Hồ sơ cá nhân',
          style: GoogleFonts.arsenal(
              color: primaryColors, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                    isDrak ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 18.0, top: 10.0, right: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //image
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          image: AssetImage(
                              'assets/images/profile/profile_user.jpg'))),
                ),
                //
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _showCameraModal(context);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: white_grey),
                      child: Icon(
                        LineAwesomeIcons.camera,
                        size: 20,
                        color: black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //name
            Text(
              'Van Dat',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10.0,
            ),
            //email
            Text('20050068@student.bdu.edu.vn'),
            SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/update_user_profile_page');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chỉnh sửa',
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                    Icon(
                      Icons.edit,
                      color: white,
                      size: 18,
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(backgroundColor: blue),
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            Divider(),
            SizedBox(
              height: 30.0,
            ),
            ProfileMenuUser(
                title: 'Cài đặt',
                startIcon: LineAwesomeIcons.cog,
                onPress: () {},
                textColor: grey),
            ProfileMenuUser(
                title: 'Đơn hàng',
                startIcon: Icons.local_shipping,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyOrderPage(), // Thay NewPage() bằng trang mới của bạn
                    ),
                  );
                },
                textColor: grey),
            ProfileMenuUser(
                title: 'Phản hồi',
                startIcon: Icons.mark_email_unread,
                onPress: () {},
                textColor: grey),
            ProfileMenuUser(
                title: 'Phương thức thanh toán',
                startIcon: LineAwesomeIcons.wallet,
                onPress: () {},
                textColor: grey),
            ProfileMenuUser(
                title: 'Quản lý tài khoản',
                startIcon: LineAwesomeIcons.user_check,
                onPress: () {},
                textColor: grey),
            ProfileMenuUser(
                title: 'Xem thêm',
                startIcon: LineAwesomeIcons.info,
                onPress: () {},
                textColor: grey),
            ProfileMenuUser(
                title: 'Đăng xuất',
                startIcon: Icons.logout,
                onPress: () {},
                endIcon: false,
                textColor: grey)
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColors,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndexBottomBar,
          onTap: _selectedBottomBar,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Icon(Icons.home)),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  // Điều hướng đến trang mới ở đây
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListProductPage(),
                    ),
                  );
                },
                child: Icon(Icons.local_dining),
              ),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteProductPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.favorite)),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.shopping_cart)),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileUserPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.person)),
              label: 'Hồ sơ',
            ),
          ]),
    );
  }
}
