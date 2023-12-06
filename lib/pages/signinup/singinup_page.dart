import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_login_signup.dart';
import 'package:highlandcoffeeapp/components/loginwithmore/login_with_more.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class SignInUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignInUpPage({super.key, required this.onTap});

  @override
  State<SignInUpPage> createState() => _SignInUpPageState();
}

class _SignInUpPageState extends State<SignInUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isObsecureName = false;
  bool isObsecurePassword = false;
  bool isObsecureConfirmPassword = false;

  //function when user signinup with email
  void signInUpUserEmail() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      // check password confirmed
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        Navigator.pop(context);
      } else {
        showErrorMessage('Password don\'t match');
      }

      // Navigator.pop(context);
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
              'Đăng ký',
              style: GoogleFonts.arsenal(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(
              height: 50.0,
            ),
            //form emali
            TextFormField(
              controller: _emailController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Email',
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
            //form name
            TextFormField(
              controller: _nameController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Passwod';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Tên hiển thị',
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _nameController.clear();
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
            //form password
            TextFormField(
              controller: _passwordController,
              obscureText: !isObsecurePassword,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Passwod';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Nhập mật khẩu',
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.vpn_key_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(isObsecurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObsecurePassword = !isObsecurePassword;
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
            //form confirm password
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !isObsecureConfirmPassword,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Passwod';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Nhập lại mật khẩu',
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.vpn_key_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(isObsecureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObsecureConfirmPassword = !isObsecureConfirmPassword;
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
              height: 40.0,
            ),
            //button signinup
            ButtonLoginSigninUp(text: 'Đăng ký', onTap: signInUpUserEmail),
            SizedBox(
              height: 40.0,
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
              height: 40.0,
            ),
            //or login with
            Center(
                child: Text('ĐĂNG NHẬP BẰNG', style: GoogleFonts.roboto(color: grey))),
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
                Text('Đã có tài khoản? ', style: GoogleFonts.roboto(color: grey)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Đăng nhập ngay!',
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
