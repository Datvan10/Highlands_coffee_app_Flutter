import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/login_with_more.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
import 'package:highlandcoffeeapp/components/widget/my_text_form_field.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class RegisterUserPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterUserPage({super.key, required this.onTap});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
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
 Future registerUser() async {
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
    // Hiển thị cảnh báo nếu có trường nào đó trống
    showEmptyFieldsAlert();
    return;
  }

  if (!passWordConfirmed()) {
    // Hiển thị cảnh báo nếu mật khẩu không khớp
    showPasswordMismatchAlert();
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      // Sau khi xác thực thành công, thêm chi tiết người dùng
      addUserDetail(email, phoneNumber, address, userName, password, confirmPassword);

      showSuccessAlert("Đăng ký thành công với email: $email");
    }
    showSuccessAlert("Đăng ký thành công với email: $email");
  } on FirebaseAuthException catch (e) {
    // Xử lý lỗi xác thực ở đây
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
            child: Text("OK", style: TextStyle(color: blue)),
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

  // Function to show Cupertino alert for empty fields
  void showEmptyFieldsAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo",
              style: GoogleFonts.arsenal(
                  color: primaryColors,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          content: Text(
            "Đăng ký không thành công, vui lòng thử lại",
          ),
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

  // Function to show Cupertino alert for password mismatch
  void showPasswordMismatchAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "Thông báo",
            style: GoogleFonts.arsenal(
                color: primaryColors,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          content: Text("Mật khẩu không khớp, vui lòng thử lại"),
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
            left: 18.0, top: 70.0, right: 18.0, bottom: 50),
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
            MyTextFormField(
              hintText: 'Email',
              prefixIconData: Icons.email,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _emailController.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: primaryColors,)),
              controller: _emailController,
              iconColor: primaryColors,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form phone number
            MyTextFormField(
              hintText: 'Số điện thoại',
              prefixIconData: Icons.phone,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _addressController.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: primaryColors,)),
              controller: _phoneNumberController,
              iconColor: primaryColors,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),

            SizedBox(
              height: 20.0,
            ),
            //form address
            MyTextFormField(
              hintText: 'Địa chỉ',
              prefixIconData: Icons.location_on,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _addressController.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: primaryColors,)),
              controller: _addressController,
              iconColor: primaryColors,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form name
            MyTextFormField(
              hintText: 'Tên hiển thị',
              prefixIconData: Icons.person,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _userNameController.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: primaryColors,)),
              controller: _userNameController,
              iconColor: primaryColors,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form password
            MyTextFormField(
              hintText: 'Mật khẩu',
              prefixIconData: Icons.vpn_key_sharp,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecurePassword ? Icons.visibility : Icons.visibility_off,
                  color: primaryColors,
                ),
                onPressed: () {
                  setState(() {
                    isObsecurePassword = !isObsecurePassword;
                  });
                },
              ),
              controller: _passWordController,
              iconColor: primaryColors,
              obscureText: !isObsecurePassword,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form confirm password
            MyTextFormField(
              hintText: 'Xác nhận mật khẩu',
              prefixIconData: Icons.vpn_key_sharp,
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
              controller: _confirmPasswordController,
              iconColor: primaryColors,
              obscureText: !isObsecureConfirmPassword,
            ),
            SizedBox(
              height: 30.0,
            ),
            //button signinup
            MyButton(
              text: 'Đăng ký',
              onTap: registerUser,
              buttonColor: primaryColors,
            ),
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
