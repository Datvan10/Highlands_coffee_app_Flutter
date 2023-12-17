import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isObsecureName = false;
  bool isObsecurePassword = false;
  bool isObsecureConfirmPassword = false;

  //
  Future signinUp() async {
    String email = _emailController.text.trim();
    int phoneNumber = int.tryParse(_phoneNumberController.text.trim()) ?? 0;
    String address = _addressController.text.trim();
    String userName = _userNameController.text.trim();
    String password = _passWordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty ||
        phoneNumber == 0 ||
        address.isEmpty ||
        userName.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Show an alert if any field is empty
      showEmptyFieldsAlert();
      return;
    }

    if (!passWordConfirmed()) {
      // Show an alert if passwords don't match
      showPasswordMismatchAlert();
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful authentication, add user details
      addUserDetail(
          email, phoneNumber, address, userName, password, confirmPassword);
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors here
      print("Lỗi xác thực: ${e.message}");
    }
  }

  //
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  //
  Future addUserDetail(String email, int phoneNumber, String address,
      String userName, String passWord, String confirmPassword) async {
    await FirebaseFirestore.instance.collection('Users').add({
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'userName': userName,
      'passWord': passWord,
      'confirmPasword': confirmPassword
    });
  }

  //
  bool passWordConfirmed() {
    if (_passWordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //
  // Function to show Cupertino alert for empty fields
  void showEmptyFieldsAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo", style: GoogleFonts.arsenal(color: primaryColors, fontSize: 18, fontWeight: FontWeight.bold)),
          content: Text("Đăng kí không thành công, vui lòng thử lại",),
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

  // Function to show Cupertino alert for password mismatch
  void showPasswordMismatchAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo", style: GoogleFonts.arsenal(color: primaryColors, fontWeight: FontWeight.bold,
                  fontSize: 18),),
          content: Text("Mật khẩu không khớp, vui lòng thử lại"),
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

  // //function when user signinup with email
  // void signInUpUserEmail() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  //   try {
  //     // check password confirmed
  //     if (_passWordController.text == _confirmPasswordController.text) {
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //           email: _emailController.text, password: _passWordController.text);
  //       Navigator.pop(context);
  //     } else {
  //       showErrorMessage('Password don\'t match');
  //     }

  //     // Navigator.pop(context);
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
            left: 20.0, top: 70.0, right: 20.0, bottom: 50),
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
              height: 30.0,
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
                  hintText: 'Email',
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
            //form phone number
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Số điện thoại',
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: white,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _phoneNumberController.clear();
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
            //form address
            TextFormField(
              controller: _addressController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Địa chỉ',
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: white,
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _addressController.clear();
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
            //form name
            TextFormField(
              controller: _userNameController,
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
                  prefixIcon: Icon(
                    Icons.person,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: primaryColors,
                    ),
                    onPressed: () {
                      setState(() {
                        _userNameController.clear();
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
              controller: _passWordController,
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
                  prefixIcon: Icon(
                    Icons.vpn_key_sharp,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObsecurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: primaryColors,
                    ),
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
                  prefixIcon: Icon(
                    Icons.vpn_key_sharp,
                    color: primaryColors,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObsecureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: primaryColors,
                    ),
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
              height: 30.0,
            ),
            //button signinup
            ButtonLoginSigninUp(text: 'Đăng ký', onTap: signinUp),
            SizedBox(
              height: 30.0,
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
              height: 20.0,
            ),
            //or login with
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
              height: 30,
            ),
            //text tip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Đã có tài khoản? ',
                    style: GoogleFonts.roboto(color: grey)),
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
