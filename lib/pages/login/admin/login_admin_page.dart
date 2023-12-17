import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_login_signup.dart';
import 'package:highlandcoffeeapp/pages/admin/services/firebase_services.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({super.key});

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  FirebaseServices _services = FirebaseServices();
  //
  final _userNameController = TextEditingController();
  final _passWordController = TextEditingController();
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    //
    void loginAcount({userName, passWord}) async {
      _services.getAdminCredentials(userName).then((value) async {
        if (value.exists) {
          if (value.data()?['userName'] == userName) {
            if (value.data()?['passWord'] == passWord) {
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  Get.offNamed('/admin_page');
                  Navigator.pop(context);
                }
              } catch (e) {
                Navigator.pop(context);
              }
              return;
            }
            return;
          }
        }
      });
    }

    //
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 150.0, right: 20.0, bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title email
            Text(
              'Đăng nhập Admin',
              style: GoogleFonts.arsenal(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(
              height: 150.0,
            ),
            //form email
            TextFormField(
              controller: _userNameController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Email...',
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: white,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _userNameController.clear();
                        });
                      },
                      icon: Icon(Icons.clear)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: white))),
            ),
            SizedBox(
              height: 20.0,
            ),
            //form password
            TextFormField(
              controller: _passWordController,
              obscureText: !isObsecure,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Passwod';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Nhập mật khẩu...',
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.vpn_key_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObsecure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: white))),
            ),
            SizedBox(
              height: 20.0,
            ),
            //edit password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Quên mật khẩu?',
                  style: GoogleFonts.roboto(
                      color: blue, decoration: TextDecoration.underline),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //button login
            ButtonLoginSigninUp(
                text: 'Đăng nhập',
                onTap: () async {
                  loginAcount(
                      userName: _userNameController.text,
                      passWord: _passWordController.text);
                }),
            // SizedBox(
            //   height: 50.0,
            // ),
            // //or continue with
            // Row(
            //   children: [
            //     Expanded(
            //       child: Divider(
            //         thickness: 1,
            //         color: grey,
            //       ),
            //     ),
            //     Text(
            //       '      hoặc      ',
            //       style: GoogleFonts.roboto(color: grey),
            //     ),
            //     Expanded(
            //       child: Divider(
            //         thickness: 1,
            //         color: grey,
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 50.0,
            // ),
            // //or login with facebook, email, google,...
            // Center(
            //     child: Text('ĐĂNG NHẬP BẰNG', style: GoogleFonts.roboto(color: grey))),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     LoginWithMore(imagePath: 'assets/icons/facebook.png'),
            //     LoginWithMore(imagePath: 'assets/icons/google.png'),
            //     LoginWithMore(imagePath: 'assets/icons/apple.png'),
            //   ],
            // ),
            // SizedBox(
            //   height: 50,
            // ),
            // //text tip
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Chưa có tài khoản? ', style: GoogleFonts.roboto(color: grey)),
            //     GestureDetector(
            //       onTap: widget.onTap,
            //       child: Text(
            //         'Đăng ký ngay!',
            //         style: GoogleFonts.roboto(
            //             color: blue,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
