import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/login_with_more.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
import 'package:highlandcoffeeapp/components/widget/my_text_form_field.dart';
import 'package:highlandcoffeeapp/pages/admin/services/firebase_services.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class LoginAdminPage extends StatefulWidget {
  final Function()? onTap;
  const LoginAdminPage({super.key, required this.onTap});

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // FirebaseServices _services = FirebaseServices();
  //
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  bool isObsecure = false;
  //
  void loginAdminEmail() async {
    String email = _emailController.text.trim();
    String password = _passWordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show an alert if either email or password is empty
      showEmptyFieldsAlert();
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Kiểm tra xem người dùng có quyền Admin không
        QuerySnapshot admins = await FirebaseFirestore.instance
            .collection('Admins')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (admins.docs.isNotEmpty) {
          String adminName = admins.docs[0]
              ['email']; // Đổi thành tên trường chứa tên email trong Firestore
          showSuccessAlert("Đăng nhập thành công với email: $adminName");
          // Hoặc chuyển đến trang AdminPage ở đây
          Navigator.pushReplacementNamed(context, '/admin_page');
        } else {
          // Đăng nhập thông thường
          showSuccessAlert("Đăng nhập thành công với email: $email");
        }
        showSuccessAlert("Đăng nhập thành công với email: $email");
      } on FirebaseAuthException catch (e) {
        // Handle authentication errors here
        print("Authentication Error: ${e.message}");
      }
    }
  }

  void showInvalidCredentialsAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "Thông báo",
            style: TextStyle(
              color: primaryColors,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text("Tài khoản hoặc mật khẩu không khớp"),
          actions: [
            CupertinoDialogAction(
              child: Text("OK", style: TextStyle(color: blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //
  void showSuccessAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "Thông báo",
            style: GoogleFonts.arsenal(
              color: primaryColors,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text("OK",style: TextStyle(color: blue)),
              onPressed: () {
                Navigator.of(context).pop();
                // Bạn có thể thêm bất kỳ hành động nào sau khi người dùng nhấn OK
              },
            ),
          ],
        );
      },
    );
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
              child: Text("OK", style: TextStyle(color: blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      body: Padding(
        padding: const EdgeInsets.only(
            left: 18.0, top: 120.0, right: 18.0, bottom: 60),
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
            MyTextFormField(
              hintText: 'Email',
              prefixIconData: Icons.email,
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
              controller: _emailController,
              iconColor: primaryColors,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form password
            MyTextFormField(
              hintText: 'Nhập mật khẩu',
              prefixIconData: Icons.vpn_key_sharp,
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
              controller: _passWordController,
              iconColor: primaryColors,
              obscureText: !isObsecure,
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
            MyButton(
              text: 'Đăng nhập',
              onTap: loginAdminEmail,
              buttonColor: primaryColors,
            ),
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
