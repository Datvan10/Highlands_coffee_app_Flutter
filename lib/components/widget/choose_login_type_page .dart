import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/pages/auth/auth_admin_page.dart';
import 'package:highlandcoffeeapp/pages/auth/auth_user_page.dart';
import 'package:highlandcoffeeapp/pages/login_sign/admin/login_admin_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class ChooseLoginTypePage extends StatefulWidget {
  @override
  State<ChooseLoginTypePage> createState() => _ChooseLoginTypePageState();
}

class _ChooseLoginTypePageState extends State<ChooseLoginTypePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hình nền
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/welcome/background_login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Các nút đăng nhập
        Padding(
          padding: const EdgeInsets.only(left: 18, top: 150, right: 18, bottom: 18.0),
          child: Column(
            children: [
              Text(
                'Chào mừng đến với Highland Coffee',
                style: GoogleFonts.abrilFatface(
                    color: white,
                    fontSize: 50.0,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 250,),
              ElevatedButton(
                onPressed: () {
                  // Di chuyển đến trang đăng nhập User
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthUserPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.login, color: blue,),
                      SizedBox(width: 100,),
                      Text('Đăng nhập User', style: TextStyle(color: black),),
                    ],
                  )),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Di chuyển đến trang đăng nhập Admin
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthAdminPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.login, color: blue,),
                      SizedBox(width: 100,),
                      Text('Đăng nhập Admin', style: TextStyle(color: black)),
                    ],
                  )),
              ),
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Di chuyển đến trang đăng nhập Admin
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Text('BACK', textAlign: TextAlign.center, style: TextStyle(color: black))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
