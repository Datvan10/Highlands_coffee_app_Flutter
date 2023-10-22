import 'package:firebase_auth/firebase_auth.dart';
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

  //function when user login with email
  void loginUserEmail() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  // function wrongEmailMessage()
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: primaryColors,
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
              'Đăng nhập',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(
              height: 150.0,
            ),
            //form email
            TextFormField(
              controller: _emailController,
              obscureText: isObsecure,
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
                          _emailController.clear();
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
                  style: TextStyle(
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
                  style: TextStyle(color: grey),
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
                child: Text('ĐĂNG NHẬP BẰNG', style: TextStyle(color: grey))),
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
                Text('Chưa có tài khoản? ', style: TextStyle(color: grey)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Đăng ký ngay!',
                    style: TextStyle(
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
