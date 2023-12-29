import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/pages/login_sign/user/login_user_page.dart';
import 'package:highlandcoffeeapp/pages/login_sign/user/register_user_page.dart.dart';

class LoginRegisterSwitcherUserPage extends StatefulWidget {
  const LoginRegisterSwitcherUserPage({super.key});

  @override
  State<LoginRegisterSwitcherUserPage> createState() => _LoginRegisterSwitcherUserPageState();
}

class _LoginRegisterSwitcherUserPageState extends State<LoginRegisterSwitcherUserPage> {
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
      return LoginUserPage(onTap: togglePage);
    }else{
      return RegisterUserPage(onTap: togglePage,);
    }
  }
}