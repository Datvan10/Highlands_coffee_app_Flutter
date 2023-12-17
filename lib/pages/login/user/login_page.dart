import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_login_signup.dart';
import 'package:highlandcoffeeapp/components/loginwithmore/login_with_more.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObsecure = false;

  //
  Future loginUserEmail() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show an alert if either email or password is empty
      showEmptyFieldsAlert();
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        // Handle authentication errors here
        print("Authentication Error: ${e.message}");
      }
    }
  }

  void dispose() {
    _emailController.text.trim();
    _passwordController.text.trim();

    super.dispose();
  }

  //
  void showEmptyFieldsAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo",
              style: GoogleFonts.arsenal(
                  color: primaryColors,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          content: Text("Đăng nhập không hợp lệ, vui lòng thử lại"),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // //function when user login with email
  // void loginUserEmail() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text, password: _passwordController.text);
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);
  //     showErrorMessage(e.code);
  //   }
  // }

  // // function wrongEmailMessage()
  // void showErrorMessage(String message) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: primaryColors,
  //           title: Center(
  //             child: Text(
  //               message,
  //               style: TextStyle(color: white),
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 110.0, right: 20.0, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title email
            Text(
              'Đăng nhập',
              style: GoogleFonts.arsenal(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(
              height: 190.0,
            ),
            //form email
            TextFormField(
              controller: _emailController,
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
                  prefixIcon: Icon(
                    Icons.email,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _emailController.clear();
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: primaryColors,
                      )),
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
              controller: _passwordController,
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
                  prefixIcon: Icon(
                    Icons.vpn_key_sharp,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObsecure ? Icons.visibility : Icons.visibility_off,
                      color: primaryColors,
                    ),
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
            ButtonLoginSigninUp(text: 'Đăng nhập', onTap: loginUserEmail),
            SizedBox(
              height: 50.0,
            ),
            //or continue with
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: grey,
                  ),
                ),
                Text(
                  '      hoặc      ',
                  style: GoogleFonts.roboto(color: grey),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            //or login with facebook, email, google,...
            Center(
                child: Text('ĐĂNG NHẬP BẰNG',
                    style: GoogleFonts.roboto(color: grey))),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginWithMore(imagePath: 'assets/icons/facebook.png'),
                LoginWithMore(imagePath: 'assets/icons/google.png'),
                LoginWithMore(imagePath: 'assets/icons/apple.png'),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            //text tip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chưa có tài khoản? ',
                    style: GoogleFonts.roboto(color: grey)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Đăng ký ngay!',
                    style: GoogleFonts.roboto(
                        color: blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
