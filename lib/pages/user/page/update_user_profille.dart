import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/edit_text_form_field.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateUserProfilePage extends StatefulWidget {
  const UpdateUserProfilePage({super.key});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  //
  final _editEmailController = TextEditingController();
  final _editPhoneNumberController = TextEditingController();
  final _editUserNameController = TextEditingController();
  final _editAdressController = TextEditingController();
  final _passwordController = TextEditingController();
  //
  void _showCameraModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          // title: Text('Chọn ảnh'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                // Xử lý khi người dùng chọn ảnh từ thư viện
                Navigator.pop(context);
              },
              child: Text('Xóa ảnh', style: TextStyle(color: blue)),
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
              child: Text('Chọn ảnh từ thư viện', style: TextStyle(color: blue)),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              // Xử lý khi người dùng nhấn nút hủy bỏ
              Navigator.pop(context);
            },
            child: Text('Hủy', style: TextStyle(color: blue,)),
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
        title: Text('Chỉnh sửa hồ sơ',
            style: GoogleFonts.arsenal(
                color: primaryColors, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 18.0, top: 50.0, right: 18.0),
          child: Column(
            children: [
              //
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
                        width: 40,
                        height: 40,
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
              //
              SizedBox(
                height: 30,
              ),
              Text(
                'Cập nhật thông tin cá nhân',
                style: TextStyle(
                  fontSize: 22,
                  color: brown,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //
              Form(
                  child: Column(
                children: [
                  //email
                  EditTextFormField(
                      hintText: 'Email',
                      prefixIconData: Icons.email,
                      suffixIconData: Icons.clear,
                      controller: _editEmailController,
                      iconColor: blue),
                  SizedBox(
                    height: 20,
                  ),
                  //phonenumber
                  EditTextFormField(
                      hintText: 'Số điện thoại',
                      prefixIconData: Icons.phone,
                      suffixIconData: Icons.clear,
                      controller: _editPhoneNumberController,
                      iconColor: blue),
                  SizedBox(
                    height: 20,
                  ),
                  //
                  EditTextFormField(
                      hintText: 'Tên hiển thị',
                      prefixIconData: Icons.person,
                      suffixIconData: Icons.clear,
                      controller: _editUserNameController,
                      iconColor: blue),
                  SizedBox(
                    height: 20,
                  ),
                  //adress
                  EditTextFormField(
                      hintText: 'Địa chỉ',
                      prefixIconData: Icons.location_on,
                      suffixIconData: Icons.clear,
                      controller: _editAdressController,
                      iconColor: blue),
                  SizedBox(
                    height: 20,
                  ),
                  //password
                  // EditTextFormField(
                  //     hintText: 'Mật khẩu',
                  //     prefixIconData: Icons.vpn_key,
                  //     suffixIconData: Icons.visibility,
                  //     controller: _passwordController,
                  //     iconColor: blue),
                  SizedBox(
                    height: 190,
                  ),
                ],
              )),
              MyButton(text: 'Cập nhật hồ sơ', onTap: () {}, buttonColor: blue)
            ],
          ),
        ),
      ),
    );
  }
}
