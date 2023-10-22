import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/pages/login/login_page.dart';
import 'package:highlandcoffeeapp/pages/signinup/singinup_page.dart';

class LoginToggleSigninupPage extends StatefulWidget {
  const LoginToggleSigninupPage({super.key});

  @override
  State<LoginToggleSigninupPage> createState() => _LoginToggleSigninupPageState();
}

class _LoginToggleSigninupPageState extends State<LoginToggleSigninupPage> {
  bool showloginPage  = true;

  //function toggle
  void togglePage(){
    setState(() {
      showloginPage = !showloginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginPage){
      return LoginPage(onTap: togglePage);
    }else{
      return SignupPage(onTap: togglePage,);
    }
  }
}